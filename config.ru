map "/" do
  use(Rack::Static, {
    :urls => ["/javascripts", "/images", "/stylesheets"],
    :root => File.join(Dir.pwd, "public")
  })

  app = lambda do |env|
    headers = {
      "Content-Type"  => "text/html",
      "Cache-Control" => "public, max-age=86400"
    }
    if env["PATH_INFO"] == "/" && env["REQUEST_METHOD"] == "GET"
      [
        200,
        headers,
        File.open("public/index.html", File::RDONLY)
      ]
    else
      [404, { "Content-Type" => "text/html" }, ["Not Found"]]
    end
  end

  run app
end
