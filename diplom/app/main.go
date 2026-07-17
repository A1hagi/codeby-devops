package main

import (
	"fmt"
	"net/http"
)

func main() {
	// Главная страница веб-приложения. Текст можно изменить для демонстрации CI/CD на защите.
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		fmt.Fprintf(w, "<h1>🚀 Дипломный проект DevOps успешно запущен!</h1>"+
			"<p>Работу выполнил студент: Alhagi (1da22@list.ru)</p>"+
			"<p>Версия сборки артефакта: стабильная (sha-latest)</p>"+
			"<p>Приложение компилируется из Go и развернуто в K3s на Senko Digital.</p>")
	})

	// Запуск веб-сервера на стандартном порту контейнера
	fmt.Println("Сервер успешно запущен на порту 8080...")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
