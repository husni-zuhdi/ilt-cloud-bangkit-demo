package app

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"

	"github.com/hazunanafaru/ilt-cloud-bangkit-demo/ilt-4/pkg/database"
	"github.com/hazunanafaru/ilt-cloud-bangkit-demo/ilt-4/pkg/handler"
	"github.com/hazunanafaru/ilt-cloud-bangkit-demo/ilt-4/pkg/model/users"
)

var (
	dbUser     = os.Getenv("DB_USER")
	dbPassword = os.Getenv("DB_PASSWORD")
	dbHost     = os.Getenv("DB_HOST")
	dbPort     = os.Getenv("DB_PORT")
	dbName     = os.Getenv("DB_NAME")
)

func Run() {
	dbUri := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable", dbUser, dbPassword, dbHost, dbPort, dbName)
	d, err := sql.Open("postgres", dbUri)
	if err != nil {
		log.Fatal(err)
	}

	queries := users.New(d)
	userService := database.NewService(queries)
	e := handler.Handlers(userService)

	e.Logger.Fatal(e.Start(":8080"))
}
