import tkinter as tk
from tkinter import scrolledtext
from arbre_de_vie_local import reponse_par_llama, lancer_ollama

class ArbreDeVieApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Arbre de Vie")

        self.input_field = tk.Entry(root, width=60)
        self.input_field.pack(padx=10, pady=10)

        self.send_button = tk.Button(root, text="Envoyer", command=self.on_send)
        self.send_button.pack(padx=10, pady=(0, 10))

        self.output_area = scrolledtext.ScrolledText(root, wrap=tk.WORD, width=60, height=20, state='disabled')
        self.output_area.pack(padx=10, pady=10)

        # Lancer Ollama au démarrage
        lancer_ollama()

    def on_send(self):
        question = self.input_field.get()
        if question:
            response = reponse_par_llama(question)
            self.output_area.config(state='normal')
            self.output_area.insert(tk.END, f"> {question}\n{response}\n\n")
            self.output_area.config(state='disabled')
            self.input_field.delete(0, tk.END)

if __name__ == "__main__":
    root = tk.Tk()
    app = ArbreDeVieApp(root)
    root.mainloop()

