rm -rf bin
cd poc_backend
go build -o bin/poc_writer cmd/poc_writer/poc_writer.go 
go build -o bin/poc_reader cmd/poc_reader/poc_reader.go 
sh build/createzip.sh