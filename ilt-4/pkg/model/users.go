package model

import (
    "context"
    "github.com/hazunanafaru/ilt-cloud-bangkit-demo/ilt-4/pkg/model/users"
)

type UseCase interface {
    Get(ctx context.Context, id int64) (*users.User, error)
    List(ctx context.Context) ([]*users.User, error)
    Create(ctx context.Context, name string) (int64, error)
    Update(ctx context.Context, user *users.User) error
    Delete(ctx context.Context, id int64) error
}
