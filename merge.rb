require 'json'

imgs = []
Dir.glob('json/*.json').each do |path|
  File.open(path) do |f|
    hash = JSON.load(f)
    path = hash['asset']['path'].split('/').slice(7..8).join('/')
    size = hash['asset']['size']
    objects = hash['regions'].map do |region|
      {
        tag: region['tags'][0],
        x: region['boundingBox']['left'],
        y: region['boundingBox']['top'],
        w: region['boundingBox']['width'],
        h: region['boundingBox']['height']
      }
    end
    imgs.push({
      path: path,
      size: size,
      objects: objects,
    })
  end
end
File.open('imgs.json', 'w') {|file| 
  file.puts(JSON.pretty_generate({imgs: imgs}))
}
