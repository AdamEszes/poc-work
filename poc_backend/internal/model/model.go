package model

import (
	"time"
)

type NewsItem struct {
	Date        time.Time
	Title       string
	Description string
}
