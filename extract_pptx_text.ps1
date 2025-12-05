$slidesPath = "temp_pptx\ppt\slides"
$output = @()
$slideFiles = Get-ChildItem -Path $slidesPath -Filter "slide*.xml" | Sort-Object Name

foreach ($slideFile in $slideFiles) {
    $slideNumber = $slideFile.Name -replace 'slide(\d+)\.xml', '$1'
    $xmlContent = [xml](Get-Content $slideFile.FullName -Raw)
    
    # Extract all text elements
    $nsManager = New-Object System.Xml.XmlNamespaceManager($xmlContent.NameTable)
    $nsManager.AddNamespace("a", "http://schemas.openxmlformats.org/drawingml/2006/main")
    $nsManager.AddNamespace("p", "http://schemas.openxmlformats.org/presentationml/2006/main")
    
    $textNodes = $xmlContent.SelectNodes("//a:t", $nsManager)
    
    if ($textNodes.Count -gt 0) {
        $slideText = ""
        foreach ($textNode in $textNodes) {
            $slideText += $textNode.InnerText
        }
        
        $output += "=== SLIDE $slideNumber ==="
        $output += $slideText.Trim()
        $output += ""
    }
}

# Save to file
$output | Out-File -FilePath "pptx_content.txt" -Encoding UTF8
Write-Host "Đã extract text từ PowerPoint và lưu vào file pptx_content.txt"
Write-Host "Tổng số slide: $($slideFiles.Count)"

