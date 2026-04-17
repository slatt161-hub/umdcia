$footerHtml = @"
<footer class="bg-[#2a2a2a] text-gray-400 w-full mt-20 px-8 py-12">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-12 max-w-screen-2xl mx-auto">
        <!-- Column 1: Contact & Visit -->
        <div class="flex flex-col space-y-4">
            <div class="font-['Work_Sans'] font-bold text-lg text-white mb-2">Contact & Visit</div>
            <address class="not-italic text-xs leading-relaxed text-gray-400 mb-2">
                1049 University Drive<br />
                Duluth, MN 55812
            </address>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://about.d.umn.edu/contact-us">Contact UMD</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://admissions.d.umn.edu/visit">Campus Tours</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://www.d.umn.edu/maps/">Maps & Directions</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://tps.d.umn.edu/">Transportation & Parking</a>
        </div>
        
        <!-- Column 2: Resources For -->
        <div class="flex flex-col space-y-4">
            <h4 class="text-white font-bold text-sm mb-2">Resources For</h4>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://admissions.d.umn.edu/ready">Newly Admitted Students</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://about.d.umn.edu/current-students">Current Students</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://about.d.umn.edu/employee-resources">Employee Resources</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://alumni.d.umn.edu/">Alumni</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://student-life.d.umn.edu/parents-and-family">Parents & Family</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://about.d.umn.edu/community">Community & Visitors</a>
        </div>

        <!-- Column 3: Search & Give -->
        <div class="flex flex-col space-y-4">
            <h4 class="text-white font-bold text-sm mb-2">Search & Give</h4>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://give.d.umn.edu/">Support UMD</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://www.d.umn.edu/department-directory/">Directory</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://hr.umn.edu/Jobs/Find-Job">Employment</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://calendar.d.umn.edu/">Events</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://lib.d.umn.edu/">Library</a>
        </div>

        <!-- Column 4: Connect -->
        <div class="flex flex-col space-y-4">
            <h4 class="text-white font-bold text-sm mb-2">Connect</h4>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://lsbe.d.umn.edu/" target="_blank" rel="noopener noreferrer">LSBE Home</a>
            <a class="text-xs hover:text-white transition-colors duration-200" href="https://d.umn.edu/" target="_blank" rel="noopener noreferrer">UMD Home</a>
            
            <div class="flex flex-col gap-3 mt-4">
                <a href="https://www.linkedin.com/company/umd-lsbe-consumer-insights-analytics-program/?viewAsMember=true" target="_blank" rel="noopener noreferrer" class="flex items-center gap-2 text-xs hover:text-[#fecb32] transition-colors">
                    <svg class="w-4 h-4 fill-current" viewBox="0 0 24 24"><path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/></svg>
                    LinkedIn
                </a>
                <a href="contact.html" class="flex items-center gap-2 text-xs hover:text-[#fecb32] transition-colors">
                    <span class="material-symbols-outlined text-[16px]">mail</span>
                    Contact Program
                </a>
            </div>
        </div>
    </div>
    
    <div class="max-w-screen-2xl mx-auto border-t border-gray-800 mt-12 pt-8 flex flex-col md:flex-row justify-between items-center gap-4">
        <p class="text-[10px] uppercase tracking-widest">© 2024 University of Minnesota Duluth - Consumer Insight &amp; Analytics</p>
        <div class="flex flex-wrap justify-center gap-4 text-[10px] uppercase tracking-widest text-gray-400">
            <a href="https://privacy.umn.edu/" class="hover:text-white">Privacy</a>
            <span class="opacity-50">|</span>
            <a href="https://accessibility.umn.edu/" class="hover:text-white">Accessibility</a>
            <span class="opacity-50">|</span>
            <a href="https://d.umn.edu/about-umd" class="hover:text-white">About UMD</a>
        </div>
    </div>
</footer>
"@

$files = @("index.html", "about.html", "academics.html", "faculty.html", "centers.html", "news.html", "info.html", "contact.html", "adminlogin.html")

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        
        # We need to find <footer and </footer> and replace everything in between
        $startTag = "<footer"
        $endTag = "</footer>"
        
        $startIndex = $content.IndexOf($startTag)
        if ($startIndex -ge 0) {
            $endIndex = $content.IndexOf($endTag, $startIndex)
            if ($endIndex -ge 0) {
                $endIndex += $endTag.Length
                $before = $content.Substring(0, $startIndex)
                $after = $content.Substring($endIndex)
                
                $newContent = $before + $footerHtml + "`n" + $after
                Set-Content $file -Value $newContent
                Write-Host "Updated footer in $file"
            }
        }
    }
}
