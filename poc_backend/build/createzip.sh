cd bin

echo "zipping lambdas..."
for f in * ; do
    echo "Zipping lambda: ${f}"
    mkdir bin
    cp ${f} bin/${f}
    command -v zip && zip ${f} ${f} -i ${f}
    rm -r bin
done