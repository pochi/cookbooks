# coding: utf-8
# Install homebrew which is management system

# NOTE: Rootパスワード聞かれるからこのレシピはそのまま実行できない
script "Install homebrew" do
	interpreter 'bash'
  user 'ITPUser'
  cwd '/tmp'
  code <<-EOC
  ruby -e "$(curl -fsSL https://gist.github.com/raw/323731/install_homebrew.rb)"
EOC
end