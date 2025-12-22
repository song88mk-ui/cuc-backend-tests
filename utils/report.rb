require 'slack-ruby-client'
require 'dotenv/load'


class Report
  def self.submit(report_name, file_name, channel_id = "C0A276YQB1P", env="dev")
    puts "Submitting results to Slack!"

    if !ENV['SLACK_API_TOKEN']
      puts "Missing ENV[SLACK_API_TOKEN]!!!, aborting"
      return
    end


		Slack.configure do |config|
			config.token = ENV['SLACK_API_TOKEN']
			'Missing ENV[SLACK_API_TOKEN]!' unless config.token
		end

		client = Slack::Web::Client.new

		auth = client.auth_test #pragma: allowlist secret
		puts "Connected to team #{auth.team} (#{auth.team_id}) as #{auth.user}."

    begin
      client.chat_postMessage(
        channel: channel_id,
        text: "Here is the latest result on *#{report_name}* on `#{env}` - Cucumber Tests!",
        as_user: true)

      client.chat_postMessage(
        channel: channel_id,
        text: "Report submitted on #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}. " +
              "Click the uploaded file and open it",
        as_user: true)

      file_content = File.read(file_name)

      result = client.files_upload_v2(
        channel_id: channel_id,
        filename: file_name,
        content: file_content,
        title: report_name)

      puts "Report URL: #{result.files.first.permalink_public}"
    rescue Slack::Web::Api::Errors::SlackError => e
      puts e
      puts "Error submitting report"
    rescue => e
      puts e
      puts "Unknown error"
    end

  end
end
