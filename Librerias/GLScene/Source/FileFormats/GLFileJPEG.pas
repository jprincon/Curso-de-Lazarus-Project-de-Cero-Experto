
// This unit is part of the GLScene Project, http://glscene.org

{: GLFileJPEG<p>

  <b>History : </b><font size=-1><ul>
      <li>23/08/10 - Yar - Replaced OpenGL1x to OpenGLTokens
      <li>29/06/10 - Yar - Improved FPC compatibility
      <li>29/04/10 - Yar - Bugfixed loading of fliped image (thanks mif)
      <li>27/02/10 - Yar - Creation
  </ul><p>
}
unit GLFileJPEG;

interface

{$I GLScene.inc}

uses
  Classes, SysUtils,
  GLCrossPlatform, OpenGLTokens, GLContext, GLGraphics, GLTextureFormat,
  ApplicationFileIO;

type

  TGLJPEGImage = class(TGLBaseImage)
  private
    FAbortLoading: boolean;
    FDivScale: longword;
    FDither: boolean;
    FSmoothing: boolean;
    FProgressiveEncoding: boolean;
    procedure SetSmoothing(const AValue: boolean);
  public
    constructor Create; override;
    class function Capabilities: TDataFileCapabilities; override;

    procedure LoadFromFile(const filename: string); override;
    procedure SaveToFile(const filename: string); override;
    procedure LoadFromStream(stream: TStream); override;
    procedure SaveToStream(stream: TStream); override;

    {: Assigns from any Texture.}
    procedure AssignFromTexture(textureContext: TGLContext;
      const textureHandle: TGLuint;
      textureTarget: TGLTextureTarget;
      const CurrentFormat: boolean;
      const intFormat: TGLInternalFormat); reintroduce;

    property Data: PGLPixel32Array read FData;
    property Width: integer read fWidth;
    property Height: integer read fHeight;
    property Depth: integer read fDepth;
    property MipLevels: integer read fMipLevels;
    property ColorFormat: GLenum read fColorFormat;
    property InternalFormat: TGLInternalFormat read fInternalFormat;
    property DataType: GLenum read fDataType;
    property ElementSize: integer read fElementSize;
    property CubeMap: boolean read fCubeMap;
    property TextureArray: boolean read fTextureArray;
    property DivScale: longword read FDivScale write FDivScale;
    property Dither: boolean read FDither write FDither;
    property Smoothing: boolean read FSmoothing write SetSmoothing;
    property ProgressiveEncoding: boolean read FProgressiveEncoding;
  end;

implementation

uses
  GLSLog,
{$IFNDEF FPC}
  GLSJPG,
{$ELSE}
  FPReadJPEG,
  fpimage,
  jmorecfg,
  jpeglib,
  jerror,
  jdeferr,
  jdmarker,
  jdmaster,
  jdapimin,
  jdapistd,
  jcparam,
  jcapimin,
  jcapistd,
  jcomapi,
  jdatasrc,
  jmemmgr,
{$ENDIF}
  VectorGeometry;

// ------------------
// ------------------ TGLJPEGImage ------------------
// ------------------

constructor TGLJPEGImage.Create;
begin
  inherited;
  FAbortLoading := False;
  FDivScale := 1;
  FDither := False;
end;

// LoadFromFile


procedure TGLJPEGImage.LoadFromFile(const filename: string);
var
  fs: TStream;
begin
  if FileStreamExists(fileName) then
  begin
    fs := CreateFileStream(fileName, fmOpenRead);
    try
      LoadFromStream(fs);
    finally
      fs.Free;
      ResourceName := filename;
    end;
  end
  else
    raise EInvalidRasterFile.CreateFmt('File %s not found', [filename]);
end;

// SaveToFile


procedure TGLJPEGImage.SaveToFile(const filename: string);
var
  fs: TStream;
begin
  fs := CreateFileStream(fileName, fmOpenWrite or fmCreate);
  try
    SaveToStream(fs);
  finally
    fs.Free;
  end;
  ResourceName := filename;
end;

// LoadFromStream

{$IFNDEF FPC}
procedure TGLJPEGImage.LoadFromStream(stream: TStream);
var
  LinesPerCall, LinesRead: integer;
  DestScanLine: Pointer;
  PtrInc: int64; // DestScanLine += PtrInc * LinesPerCall
  jc: TJPEGContext;
begin
  if Stream.Size > 0 then
  begin
    FAbortLoading := False;

    FillChar(jc, sizeof(jc), $00);
    jc.err := jpeg_std_error;
    jc.common.err := @jc.err;

    jpeg_CreateDecompress(@jc.d, JPEG_LIB_VERSION, SizeOf(jc.d));
    try
      jc.progress.progress_monitor := @JPEGLIBCallback;
      jc.progress.instance := Self;
      jc.common.progress := @jc.progress;

      jpeg_stdio_src(@jc.d, Stream);

      jpeg_read_header(@jc.d, True); // require Image
      jc.d.scale_num := 1;
      jc.d.scale_denom := FDivScale;
      jc.d.do_block_smoothing := FSmoothing;
      jc.d.dct_method := JDCT_ISLOW;
      // Standard. Float ist unwesentlich besser, aber 20 Prozent langsamer
      if FDither then
        jc.d.dither_mode := JDITHER_FS
      // Ordered ist nicht schneller, aber h��licher
      else
        jc.d.dither_mode := JDITHER_NONE;
      jc.FinalDCT := jc.d.dct_method;
      jc.FinalTwoPassQuant := jc.d.two_pass_quantize; // True
      jc.FinalDitherMode := jc.d.dither_mode; // FS

      if jpeg_has_multiple_scans(@jc.d) then
      begin // maximaler Speed beim Progressing, Hi Q erst beim letzten Scan
        jc.d.enable_2pass_quant := jc.d.two_pass_quantize;
        jc.d.dct_method := JDCT_IFAST;
        jc.d.two_pass_quantize := False;
        jc.d.dither_mode := JDITHER_ORDERED;
        jc.d.buffered_image := True;
      end;

      // Format des Bitmaps und Palettenbestimmung
      if jc.d.out_color_space = JCS_GRAYSCALE then
      begin
        fColorFormat := GL_LUMINANCE;
        fInternalFormat := tfLUMINANCE8;
        fElementSize := 1;
      end
      else
      begin
        fColorFormat := GL_BGR;
        fInternalFormat := tfRGB8;
        fElementSize := 3;
      end;
      fDataType := GL_UNSIGNED_BYTE;

      jpeg_start_decompress(@jc.d); // liefert erst einmal JPGInfo
      fWidth := jc.d.output_width;
      fHeight := jc.d.output_height;
      fDepth := 0;
      fMipLevels := 1;
      fCubeMap := False;
      fTextureArray := False;
      ReallocMem(fData, DataSize);
      fLevels.Clear;
      DestScanLine := fData;
      PtrInc := PtrUInt(fData) - PtrUInt(DestScanline) + PtrUInt(fWidth * fElementSize);
      if (PtrInc > 0) and ((PtrInc and 3) = 0) then
        LinesPerCall := jc.d.rec_outbuf_height // mehrere Scanlines pro Aufruf
      else
        LinesPerCall := 1; // dabei wird's wohl einstweilen bleiben...

      if jc.d.buffered_image then
      begin
        // progressiv. Decoding mit Min Quality (= max speed)
        while jpeg_consume_input(@jc.d) <> JPEG_REACHED_EOI do
        begin
          jpeg_start_output(@jc.d, jc.d.input_scan_number);
          // ein kompletter Pass. Reset Oberkante progressives Display
          while jc.d.output_scanline < jc.d.output_height do
          begin
            DestScanLine := Pointer(PtrUInt(fData) +
              (jc.d.output_height - jc.d.output_scanline - 1) *
              PtrUInt(fWidth) * PtrUInt(fElementSize));
            jpeg_read_scanlines(@jc.d, @DestScanLine, LinesPerCall);
          end;
          jpeg_finish_output(@jc.d);
        end;
        // f�r den letzten Pass die tats�chlich gew�nschte Ausgabequalit�t
        jc.d.dct_method := jc.FinalDCT;
        jc.d.dither_mode := jc.FinalDitherMode;
        if jc.FinalTwoPassQuant then
        begin
          jc.d.two_pass_quantize := True;
          jc.d.colormap := nil;
        end;
        jpeg_start_output(@jc.d, jc.d.input_scan_number);
        DestScanLine := fData;
      end;

      // letzter Pass f�r progressive JPGs, erster & einziger f�r Baseline-JPGs
      while (jc.d.output_scanline < jc.d.output_height) do
      begin
        DestScanLine := Pointer(PtrUInt(fData) +
          (jc.d.output_height - jc.d.output_scanline - 1) *
          PtrUInt(fWidth) * PtrUInt(fElementSize));
        jpeg_read_scanlines(@jc.d, @DestScanline, LinesPerCall);
      end;

      // letzter Pass f�r progressive JPGs, erster & einziger f�r Baseline-JPGs
      while (jc.d.output_scanline < jc.d.output_height) do
      begin
        LinesRead := jpeg_read_scanlines(@jc.d, @DestScanline, LinesPerCall);
        Inc(PtrUInt(DestScanline), PtrInc * LinesRead);
        if FAbortLoading then
          Exit;
      end;

      if jc.d.buffered_image then
        jpeg_finish_output(@jc.d);
      jpeg_finish_decompress(@jc.d);

    finally
      if jc.common.err <> nil then
        jpeg_destroy(@jc.common);
      jc.common.err := nil;
    end;
  end;
end;

{$ELSE}

procedure JPEGError(CurInfo: j_common_ptr);
begin
  if CurInfo = nil then
    exit;
  raise Exception.CreateFmt('JPEG error', [CurInfo^.err^.msg_code]);
end;

procedure EmitMessage(CurInfo: j_common_ptr; msg_level: integer);
begin
  if CurInfo = nil then
    exit;
  if msg_level = 0 then
  ;
end;

procedure OutputMessage(CurInfo: j_common_ptr);
begin
  if CurInfo = nil then
    exit;
end;

procedure FormatMessage(CurInfo: j_common_ptr; var buffer: string);
begin
  if CurInfo = nil then
    exit;
  GLSLogger.LogInfo(buffer);
end;

procedure ResetErrorMgr(CurInfo: j_common_ptr);
begin
  if CurInfo = nil then
    exit;
  CurInfo^.err^.num_warnings := 0;
  CurInfo^.err^.msg_code := 0;
end;

procedure ProgressCallback(CurInfo: j_common_ptr);
begin
  if CurInfo = nil then
    exit;
  // ToDo
end;

var
  jpeg_std_error: jpeg_error_mgr;

procedure TGLJPEGImage.LoadFromStream(stream: TStream);
var
  MemStream: TMemoryStream;
  vInfo: jpeg_decompress_struct;
  vError: jpeg_error_mgr;
  jc: TFPJPEGProgressManager;

  procedure SetSource;
  begin
    MemStream.Position := 0;
    jpeg_stdio_src(@vInfo, @MemStream);
  end;

  procedure ReadHeader;
  begin
    jpeg_read_header(@vInfo, True);
    FWidth := vInfo.image_width;
    FHeight := vInfo.image_height;
    FDepth := 0;
    if vInfo.jpeg_color_space = JCS_CMYK then
    begin
      FColorFormat := GL_RGBA;
      FInternalFormat := tfRGBA8;
      FElementSize := 4;
    end
    else
    if vInfo.out_color_space = JCS_GRAYSCALE then
    begin
      FColorFormat := GL_LUMINANCE;
      FInternalFormat := tfLUMINANCE8;
      FElementSize := 1;
    end
    else
    begin
      FColorFormat := GL_RGB;
      FInternalFormat := tfRGB8;
      FElementSize := 3;
    end;
    FDataType := GL_UNSIGNED_BYTE;
    FMipLevels := 1;
    FCubeMap := False;
    FTextureArray := False;
    ReallocMem(FData, DataSize);
    FLevels.Clear;
    FProgressiveEncoding := jpeg_has_multiple_scans(@vInfo);
  end;

  procedure InitReadingPixels;
  begin
    vInfo.scale_num := 1;
    vInfo.scale_denom := 1;
    vInfo.do_block_smoothing := FSmoothing;

    if vInfo.out_color_space = JCS_GRAYSCALE then
    begin
      vInfo.quantize_colors := True;
      vInfo.desired_number_of_colors := 236;
    end;

    if FProgressiveEncoding then
    begin
      vInfo.enable_2pass_quant := vInfo.two_pass_quantize;
      vInfo.buffered_image := True;
    end;
  end;

  function CorrectCMYK(const C: TFPColor): TFPColor;
  var
    MinColor: word;
  begin
    if C.red < C.green then
      MinColor := C.red
    else
      MinColor := C.green;
    if C.blue < MinColor then
      MinColor := C.blue;
    if MinColor + C.alpha > $FF then
      MinColor := $FF - C.alpha;
    Result.red := (C.red - MinColor) shl 8;
    Result.green := (C.green - MinColor) shl 8;
    Result.blue := (C.blue - MinColor) shl 8;
    Result.alpha := alphaOpaque;
  end;

  procedure ReadPixels;
  var
    SampArray: JSAMPARRAY;
    SampRow: JSAMPROW;
    Color: TFPColor;
    LinesRead: Cardinal;
    y: Integer;
    Status, Scan: integer;
    ReturnValue, RestartLoop: boolean;

    procedure OutputScanLines();
    var
      x: integer;
      pPixel: PByte;
    begin
      Color.Alpha := alphaOpaque;
      y := FHeight - 1;
      while (vInfo.output_scanline < vInfo.output_height) do
      begin
        // read one line per call
        LinesRead := jpeg_read_scanlines(@vInfo, SampArray, 1);
        if LinesRead < 1 then
        begin
          ReturnValue := False;
          break;
        end;
        pPixel := @PByteArray(FData)[y*FWidth*FElementSize];

        if vInfo.jpeg_color_space = JCS_CMYK then
        begin
          for x := 0 to vInfo.output_width - 1 do
          begin
            Color.Red := SampRow^[x * 4 + 0];
            Color.Green := SampRow^[x * 4 + 1];
            Color.Blue := SampRow^[x * 4 + 2];
            Color.alpha := SampRow^[x * 4 + 3];
            Color := CorrectCMYK(Color);
            pPixel^:= Color.red; Inc(pPixel);
            pPixel^:= Color.green; Inc(pPixel);
            pPixel^:= Color.blue; Inc(pPixel);
            pPixel^:= Color.alpha; Inc(pPixel);
          end;
        end
        else // RGB or LUMINANCE
          Move(SampRow^[0], pPixel^, FElementSize * vInfo.output_width);

        Dec(y);
      end;
    end;

  begin
    InitReadingPixels;

    jpeg_start_decompress(@vInfo);

    GetMem(SampArray, SizeOf(JSAMPROW));
    GetMem(SampRow, vInfo.output_width * vInfo.output_components);
    SampArray^[0] := SampRow;
    try
      case FProgressiveEncoding of
        False:
          begin
            ReturnValue:=true;
            OutputScanLines();
            if vInfo.buffered_image then jpeg_finish_output(@vInfo);
          end;
        True:
          begin
            while true do
            begin
              (* The RestartLoop variable drops a placeholder for suspension
                 mode, or partial jpeg decode, return and continue. In case
                 of support this suspension, the RestartLoop:=True should be
                 changed by an Exit and in the routine enter detects that it
                 is being called from a suspended state to not
                 reinitialize some buffer *)
              RestartLoop:=false;
              repeat
                status := jpeg_consume_input(@vInfo);
              until (status=JPEG_SUSPENDED) or (status=JPEG_REACHED_EOI);
              ReturnValue:=true;
              if vInfo.output_scanline = 0 then
              begin
                Scan := vInfo.input_scan_number;
                (* if we haven't displayed anything yet (output_scan_number==0)
                  and we have enough data for a complete scan, force output
                  of the last full scan *)
                if (vInfo.output_scan_number = 0) and (Scan > 1) and
                  (status <> JPEG_REACHED_EOI) then Dec(Scan);

                if not jpeg_start_output(@vInfo, Scan) then
                begin
                  RestartLoop:=true; (* I/O suspension *)
                end;
              end;

              if not RestartLoop then
              begin
                if (vInfo.output_scanline = $ffffff) then
                  vInfo.output_scanline := 0;

                OutputScanLines();

                if ReturnValue=false then begin
                  if (vInfo.output_scanline = 0) then
                  begin
                     (* didn't manage to read any lines - flag so we don't call
                        jpeg_start_output() multiple times for the same scan *)
                     vInfo.output_scanline := $ffffff;
                  end;
                  RestartLoop:=true; (* I/O suspension *)
                end;

                if not RestartLoop then
                begin
                  if (vInfo.output_scanline = vInfo.output_height) then
                  begin
                    if not jpeg_finish_output(@vInfo) then
                    begin
                      RestartLoop:=true; (* I/O suspension *)
                    end;

                    if not RestartLoop then
                    begin
                      if (jpeg_input_complete(@vInfo) and
                         (vInfo.input_scan_number = vInfo.output_scan_number)) then
                        break;

                      vInfo.output_scanline := 0;
                    end;
                  end;
                end;
              end;
              if RestartLoop then
                break;
            end;
          end;
      end;
    finally
      FreeMem(SampRow);
      FreeMem(SampArray);
    end;

    jpeg_finish_decompress(@vInfo);
  end;

begin
  MemStream := nil;
  FillChar(vInfo, SizeOf(vInfo), $00);
  try

    if stream is TMemoryStream then
      MemStream := TMemoryStream(stream)
    else
    begin
      MemStream := TMemoryStream.Create;
      MemStream.CopyFrom(stream, stream.Size - stream.Position);
      MemStream.Position := 0;
    end;

    if MemStream.Size > 0 then
    begin
      vError := jpeg_std_error;
      vInfo.err := @vError;
      jpeg_CreateDecompress(@vInfo, JPEG_LIB_VERSION, SizeOf(vInfo));
      try
        jc.pub.progress_monitor := @ProgressCallback;
        jc.instance := Self;
        vInfo.progress := @jc.pub;
        SetSource;
        ReadHeader;
        ReadPixels;
      finally
        jpeg_Destroy_Decompress(@vInfo);
      end;
    end;
  finally
    if Assigned(MemStream) and (MemStream <> stream) then
      MemStream.Free;
  end;
end;

{$ENDIF}


procedure TGLJPEGImage.SaveToStream(stream: TStream);
begin

end;

// AssignFromTexture


procedure TGLJPEGImage.AssignFromTexture(textureContext: TGLContext;
  const textureHandle: TGLuint; textureTarget: TGLTextureTarget;
  const CurrentFormat: boolean; const intFormat: TGLInternalFormat);
begin

end;

procedure TGLJPEGImage.SetSmoothing(const AValue: boolean);
begin
  if FSmoothing <> AValue then
    FSmoothing := AValue;
end;

// Capabilities


class function TGLJPEGImage.Capabilities: TDataFileCapabilities;
begin
  Result := [dfcRead {, dfcWrite}];
end;

initialization

{$IFDEF FPC}
  with jpeg_std_error do
  begin
    error_exit := @JPEGError;
    emit_message := @EmitMessage;
    output_message := @OutputMessage;
    format_message := @FormatMessage;
    reset_error_mgr := @ResetErrorMgr;
  end;
{$ENDIF}

  { Register this Fileformat-Handler with GLScene }
  RegisterRasterFormat('jpg', 'Joint Photographic Experts Group Image',
    TGLJPEGImage);
  RegisterRasterFormat('jpeg', 'Joint Photographic Experts Group Image',
    TGLJPEGImage);
  RegisterRasterFormat('jpe', 'Joint Photographic Experts Group Image',
    TGLJPEGImage);
end.

