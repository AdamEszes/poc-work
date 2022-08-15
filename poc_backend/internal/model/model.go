package model

import (
	"time"
)

type NewsItem struct {
	Date        time.Time `json:"Date"`
	Title       string    `json:"Title"`
	Description string    `json:"Description"`
}
