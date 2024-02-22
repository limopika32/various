Sub FormatClear()
'
' FormatClear Macro
' 書式のリセット
'
    Selection.ClearFormatting
End Sub

Sub toSource()
'
' toSource Macro
'
'
    Selection.Font.Name = "Consolas"
    With Selection.Font.Shading
        If .Texture = wdTextureNone Then
            .Texture = wdTexture15Percent
            .ForegroundPatternColor = wdColorBlack
            .BackgroundPatternColor = wdColorWhite
        Else
            .Texture = wdTextureNone
        End If
    End With
End Sub