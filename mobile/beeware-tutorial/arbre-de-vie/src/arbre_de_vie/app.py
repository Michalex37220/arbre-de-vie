import toga
from toga.style import Pack
from toga.constants import COLUMN

class SimpleWebViewApp(toga.App):
    def startup(self):
        self.main_window = toga.MainWindow(title=self.name)

        # Créer un WebView avec une URL de départ
        self.webview = toga.WebView(
            url="https://probable-fawn-evidently.ngrok-free.app/",
            style=Pack(flex=1),
        )

        # Boîte principale
        box = toga.Box(
            children=[self.webview],
            style=Pack(direction=COLUMN, flex=1)
        )

        self.main_window.content = box
        self.main_window.show()

def main():
    return SimpleWebViewApp("L'arbre de Vie, une application goatesque", "https://github.com/Michalex37220/arbre-de-vie")

if __name__ == "__main__":
    app = main()
    app.main_loop()

