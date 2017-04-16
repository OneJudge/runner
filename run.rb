require 'docker'

command = [
  'bash',
  '-c',
  'gcc -o /out /example.c && /out'
]

container = Docker::Container.create(
  'Cmd': command,
  'Image' => 'onejudge/c_cpp',
  'AttachStdout': true
)

container.store_file("/example.c", File.read("example.c"))
container.tap(&:start).attach { |stream, chunk| puts "#{stream}: #{chunk}" }
