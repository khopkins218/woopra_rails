module WoopraRails
  module Rails
    class Engine < ::Rails::Engine
      initializer "woopra_rails.load_config" do |app|
        if File.exists? "#{app.root}/config/woopra.yml"
          WoopraRails.config = YAML.load_file(app.root.join("config","woopra.yml"))[::Rails.env]
        else
          raise WoopraError, "Missing woopra.yml in Rails root config directory."
        end
      end
    end
  end
end