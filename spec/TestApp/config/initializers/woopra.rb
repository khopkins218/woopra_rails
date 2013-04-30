begin
  WoopraRails.config = YAML.load_file(Rails.root.join("config","woopra.yml"))[Rails.env]
  WoopraRails.init
end