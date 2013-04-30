module WoopraRails
  module Rails
    class Engine < ::Rails::Engine
      initializer "woopra_rails.load_config" do |app|
        WoopraRails.config = YAML.load_file(app.root.join("config","woopra.yml"))[::Rails.env]
        WoopraRails.init
      end
    end
  end
end