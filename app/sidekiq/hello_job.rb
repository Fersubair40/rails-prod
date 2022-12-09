class HelloJob
  include Sidekiq::Job

  def perform(id)
    Book.find(id).update(title: "Hello")
  end
end
