def save_attachment_file(file)
  puts "file: #{file}"
  tempfile = file[:tempfile]
  filename = file[:filename]

  extension = File.extname(filename)
  folder = extension[1..-1]

  folder = 'file' unless %w[jpg png gif mp4].include? folder

  folder_path = "public/#{folder}"
  file_path = "#{folder_path}/#{filename}"

  FileUtils.mkdir_p "./#{folder_path}"
  FileUtils.copy(tempfile.path, file_path)

  file_path
end