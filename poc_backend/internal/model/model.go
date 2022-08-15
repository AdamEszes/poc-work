package model

import (
	"time"
)

type NewsItem struct {
	Date        time.Time `json:"date"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
}
