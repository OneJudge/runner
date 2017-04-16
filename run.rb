require 'docker'

command = [
  'bash',
  '-c',
  'gcc -o /out /example.c && /out'
]

container = Docker::Container.create(
  'Cmd': command,
  'Image' => 'onejudge/c_cpp',
  'AttachStdout': true,
  'Tty': true,
)

container.store_file("/example.c", File.read("example.c"))
container.start

puts container.logs(stdout: true, stderr: true)
