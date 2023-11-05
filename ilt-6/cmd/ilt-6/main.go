package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.Static("/", "./assets")

    router.Run(":80")
}
