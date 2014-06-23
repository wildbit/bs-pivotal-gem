# Pivotal

Yet another lightweight Pivotal Tracker API v5 client for Ruby

## Installation

Add this line to your application's Gemfile:

    gem 'pivotal'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pivotal

## Usage

### Create a Client object

    @client = Pivotal::Client.new("user token goes here")

### Find all Projects

	projects = @client.projects
	# => [#<Pivotal::Project id=12345, name="Pivotal.rb">]

### Find a single Project

	project = @client.project(project_id)
	# => #<Pivotal::Project id=12345, name="Pivotal.rb">

### Find all Epics for a Project

	epics = @client.epics(project_id)
	# => [#<Pivotal::Epic id=12345, name="Integration with Beanstalk">]

### Find a single Epic in a Project

	epic = @client.epic(epic_id)
	# => #<Pivotal::Epic id=12345, name="Integration with Beanstalk">

### Find all Comments for an Epic

	comments = @client.epic_comments(epic_id)
	# => [#<Pivotal::Comment id=12345, text="New Commit in Pivotal.rb Project">]

### Find a single Comment for an Epic

	comment = @client.epic_comment(epic_id, comment_id)
	# => #<Pivotal::Comment id=12345, text="New Commit in Pivotal.rb Project">

### Create an Epic Comment

	@client.new_epic_comment(project_id, epic_id, "Comment Body")
	# => #<Pivotal::Comment id=12345, text="Comment Body">

### Find all Stories for a Project

	stories = @client.stories(project_id)
	# => [#<Pivotal::Story id=12345, name="Write Ruby client">]

### Find a single Story in a Project

	story = @client.story(story_id)
	# => #<Pivotal::Story id=12345, name="Write Ruby client">

### Find all Comments for a Story

	comments = @client.story_comments(story_id)
	# => [#<Pivotal::Comment id=12345, text="New Commit in Pivotal.rb Project">]

### Find a single Comment for a Story

	comment = @client.story_comment(story_id, comment_id)
	# => #<Pivotal::Comment id=12345, text="New Commit in Pivotal.rb Project">

### Create a Story Comment

	@client.new_story_comment(project_id, story_id, "Comment Body")
	# => #<Pivotal::Comment id=12345, text="Comment Body">


## Contributing

1. Clone repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Merge Request

## Questions?

HipChat!
