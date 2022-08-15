package config

import (
	"os"
)

func NewsTable() string { return os.Getenv("NEWS_TABLE") }
