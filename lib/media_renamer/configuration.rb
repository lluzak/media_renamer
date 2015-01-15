require 'yaml'

class MediaRenamer::Configuration
  def initialize(config_path)
    @config_path = config_path
  end

  def read!
    content = File.read(@config_path)
    config = parse_yaml_string(content)
    assert_config_keys(config)

    @config = config

    self
  rescue Errno::ENOENT
    raise MediaRenamer::ConfigFileError, "Configuration file #{@config_path} not found"
  end

  def watch_directory
    @config["watch_directory"]
  end

  def library_movie_directory
    File.join(base_path, directory_names["movie"] || "Movies")
  end

  def library_tv_show_directory
    File.join(base_path, directory_names["tv_show"] || "TV Shows")
  end

  def library_anime_directory
    File.join(base_path, directory_names["anime"] || "Animes")
  end

  private

  def base_path
    @config["library"]["base_path"]
  end

  def directory_names
    @config["library"]["directory_names"]
  end

  def assert_config_keys(config)
    raise MediaRenamer::ConfigFileError,
      "Configuration file #{@config_path} is missing base_path or watch_directory keys" if required_config_keys_blank?(config)
  end

  def required_config_keys_blank?(config)
    config["watch_directory"].nil? || config["library"].nil? || config["library"]["base_path"].nil?
  end

  def parse_yaml_string(content)
    YAML.load(content)
  rescue Psych::SyntaxError, StandardError
    raise MediaRenamer::ConfigFileError,
      "Configuration file #{@config_path} contains malformed content"
  end
end
