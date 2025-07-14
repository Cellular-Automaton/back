docker build -t back_dev -f .dev/Dockerfile .
docker run -p 4000:4000 back_dev
