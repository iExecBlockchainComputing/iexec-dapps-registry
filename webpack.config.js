module.exports = {
    entry: {
        app: './app/js/app.js'
    },
    output: {
        path: __dirname + "/build/app/js",
        filename: "[name].js"
    },
    module: {
        loaders: [
            { test: /\.css$/, loader: "style-loader!css-loader" }
        ]
    }
};