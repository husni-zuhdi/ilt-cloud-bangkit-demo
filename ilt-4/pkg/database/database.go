package database

import (
	"context"
	"fmt"

	"github.com/hazunanafaru/ilt-cloud-bangkit-demo/ilt-4/pkg/model/users"
)

// Service define a service
type Service struct {
	query *users.Queries
}

// Create new service
func NewService(query *users.Queries) *Service {
	return &Service{
		query: query,
	}
}

// Get a user
func (s *Service) Get(ctx context.Context, id int64) (*users.User, error) {
	u, err := s.query.GetUser(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("error reading from database: %w", err)
	}
	return &users.User{
		ID:   u.ID,
		Name: u.Name,
	}, nil
}

// List Users
func (s *Service) List(ctx context.Context) ([]*users.User, error) {
	us, err := s.query.ListUsers(ctx)
	if err != nil {
		return nil, fmt.Errorf("error reading from database: %w", err)
	}
	var list_users []*users.User
	for _, u := range us {
		list_users = append(list_users, &users.User{
			ID:   u.ID,
			Name: u.Name,
		})
	}
	return list_users, nil
}

// Create a user
func (s *Service) Create(ctx context.Context, Name string) (int64, error) {
	result, err := s.query.CreateUser(ctx, Name)
	if err != nil {
		return 0, fmt.Errorf("error creating user: %w", err)
	}
	id := result.ID
	return id, nil
}

// Update user data
func (s *Service) Update(ctx context.Context, user *users.User) error {
	err := s.query.UpdateUser(ctx, users.UpdateUserParams{
		ID:   user.ID,
		Name: user.Name,
	})
	if err != nil {
		return fmt.Errorf("error updating user: %w", err)
	}
	return nil
}

// Delete remove a user
func (s *Service) Delete(ctx context.Context, id int64) error {
	err := s.query.DeleteUser(ctx, id)
	if err != nil {
		return fmt.Errorf("error removing user: %w", err)
	}
	return nil
}
