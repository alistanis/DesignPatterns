require 'bundler/gem_tasks'


def compile_extensions
  extensions = Dir.glob('ext/**/extconf.rb')

  extensions.each do |ext|
    extension_name = ext.gsub('ext/', '').gsub('/extconf.rb', '')
    extension_path = File.expand_path('../../', __FILE__) + "/DesignPatterns/ext/#{extension_name}/"
    Dir.chdir(extension_path)
    puts `./extconf.rb; make; make install; cp #{extension_name}.bundle ../../lib; cp #{extension_name}.o ../../lib;`
  end
end

task :default do
  compile_extensions
end