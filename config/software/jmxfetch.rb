name "jmxfetch"

if windows?
  default_version "0.34.0"
else
  jmx_version = ENV["JMX_VERSION"]
  if jmx_version.nil? || jmx_version.empty?
    raise "Please specify a JMX_VERSION env variable to build."
  else
    default_version jmx_version
  end
end

version "0.34.0" do
  source sha256: "b5c053b960f9fa949a76ec3b84c308586c409f956379481e6a0044867deb7b52"
end

jar_dir = "#{install_dir}/agent/checks/libs"
agent_version = ENV["AGENT_VERSION"] || "5"
if agent_version[0] == "6"
  jar_dir = "#{install_dir}/bin/agent/dist/jmx"
end

source :url => "https://dl.bintray.com/datadog/datadog-maven/com/datadoghq/jmxfetch/#{version}/jmxfetch-#{version}-jar-with-dependencies.jar"

relative_path "jmxfetch"

build do
  ship_license "https://raw.githubusercontent.com/DataDog/jmxfetch/master/LICENSE"
  mkdir jar_dir
  copy "jmxfetch-#{version}-jar-with-dependencies.jar", jar_dir
  block { File.chmod(0644, "#{jar_dir}/jmxfetch-#{version}-jar-with-dependencies.jar") }
end
