package handler

import (
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"

	"github.com/hazunanafaru/ilt-cloud-bangkit-demo/ilt-4/pkg/model"
	"github.com/hazunanafaru/ilt-cloud-bangkit-demo/ilt-4/pkg/model/users"
)

// Handlers
func Handlers(userUC model.UseCase) *echo.Echo {
    // Create new API server
    e := echo.New()

    // Middleware
    e.Use(middleware.Logger())
    e.Use(middleware.Recover())

    //Routing
    e.POST("/users", createUser(userUC))
    e.GET("/users/:id", getUser(userUC))
    e.PUT("/users/:id", updateUser(userUC))
    e.DELETE("/users/:id", deleteUser(userUC))

    return e
}

func createUser(userUC model.UseCase) echo.HandlerFunc {
    return func(c echo.Context) error {
        u := new(users.User)

        if err := c.Bind(u); err != nil {
            return err
        }

        id, err := userUC.Create(c.Request().Context(), u.Name)
        if err != nil {
            return err
        }

        u.ID = id
        return c.JSON(http.StatusCreated, u)
    }
}

func getUser(userUC model.UseCase) echo.HandlerFunc {
    return func(c echo.Context) error {
        id, _ := strconv.Atoi(c.Param("id"))
        user, err := userUC.Get(c.Request().Context(), int64(id))
        if err != nil {
            return err
        }
        return c.JSON(http.StatusOK, user)
    }
}

func updateUser(userUC model.UseCase) echo.HandlerFunc {
    return func(c echo.Context) error {
        u := new(users.User)

        if err := c.Bind(u); err != nil {
            return err
        }

        id, _ := strconv.Atoi(c.Param("id"))
        u.ID = int64(id)

        if err := userUC.Update(c.Request().Context(), u); err != nil {
            return err
        }

        return c.JSON(http.StatusOK, u)
        
    }
}

func deleteUser(userUC model.UseCase) echo.HandlerFunc {
    return func(c echo.Context) error {
        id, _ := strconv.Atoi(c.Param("id"))
        if err := userUC.Delete(c.Request().Context(), int64(id)); err != nil {
            return err
        }

        return c.NoContent(http.StatusNoContent)
    }
}
