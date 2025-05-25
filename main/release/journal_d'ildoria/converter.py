import asyncio
from playwright.async_api import async_playwright
import os

async def capture_full_page(html_path, output_image="page_capture.png"):
    html_file = os.path.abspath(html_path)
    file_url = f"file://{html_file}"

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page()

        # Aller à la page HTML locale
        await page.goto(file_url, wait_until="networkidle")

        # Attendre les animations / JS supplémentaires si nécessaire
        await page.wait_for_timeout(2000)

        # Faire une capture d'écran de la page entière
        await page.screenshot(path=output_image, full_page=True)
        print(f"✅ Capture enregistrée dans : {output_image}")

        await browser.close()

# Pour lancer le script
if __name__ == "__main__":
    html_input = "/home/kali/Téléchargements/bootstrap-news-template/index.html"
    asyncio.run(capture_full_page(html_input, "page_capture.png"))

