$js = @"
<script>
document.addEventListener('DOMContentLoaded', () => {
    const nav = document.querySelector('nav');
    if (!nav) return;
    const desktopLinksContainer = nav.querySelector('.hidden.md\\:flex.items-center.space-x-8');
    const rightButtonsContainer = nav.querySelector('.flex.items-center.gap-4');
    if (desktopLinksContainer) {
        desktopLinksContainer.classList.remove('md:flex');
        desktopLinksContainer.classList.add('lg:flex');
    }
    if (rightButtonsContainer) {
        rightButtonsContainer.classList.add('hidden', 'lg:flex');
        rightButtonsContainer.classList.remove('flex');
    }
    const topBar = nav.querySelector('.flex.items-center.justify-between');
    if (topBar && !nav.querySelector('#mobile-hamburger')) {
        const hamburgerBtn = document.createElement('button');
        hamburgerBtn.id = 'mobile-hamburger';
        hamburgerBtn.className = 'lg:hidden text-[#811026] dark:text-[#fecb32] focus:outline-none p-2 ml-auto';
        hamburgerBtn.innerHTML = '<span class="material-symbols-outlined text-3xl">menu</span>';
        topBar.appendChild(hamburgerBtn);
        const mobileMenu = document.createElement('div');
        mobileMenu.className = 'hidden lg:hidden bg-white/95 dark:bg-[#1a1c1d]/95 backdrop-blur-md border-t border-outline-variant/30 overflow-hidden';
        const mobileLinksDiv = document.createElement('div');
        mobileLinksDiv.className = 'flex flex-col px-8 py-6 space-y-4 font-["Work_Sans"] font-medium text-lg text-center';
        if (desktopLinksContainer) {
            Array.from(desktopLinksContainer.children).forEach(link => {
                const clone = link.cloneNode(true);
                clone.style.display = 'block';
                clone.style.padding = '8px 0';
                mobileLinksDiv.appendChild(clone);
            });
        }
        if (rightButtonsContainer) {
            const separator = document.createElement('hr');
            separator.className = 'border-outline-variant/30 my-4 w-full';
            mobileLinksDiv.appendChild(separator);
            Array.from(rightButtonsContainer.children).forEach(btn => {
                const clone = btn.cloneNode(true);
                clone.className = clone.className + ' block w-full text-center mt-2';
                mobileLinksDiv.appendChild(clone);
            });
        }
        mobileMenu.appendChild(mobileLinksDiv);
        nav.appendChild(mobileMenu);
        hamburgerBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
        });
    }
});
</script>
"@

$files = @("index.html", "about.html", "academics.html", "faculty.html", "centers.html", "news.html", "info.html", "contact.html", "adminlogin.html")

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        if (-not $content.Contains("desktopLinksContainer")) {
            $content = $content.Replace("</body></html>", "`n$js`n</body></html>")
            Set-Content $file -Value $content
        }
    }
}
