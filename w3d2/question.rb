class Question
  # CREATE TABLE questions (
  #   id INTEGER PRIMARY KEY,
  #   title VARCHAR(255) NOT NULL,
  #   body TEXT,
  #   user_id INTEGER NOT NULL,
  #   FOREIGN KEY (user_id) REFERENCES users(id)
  # );
  include Saveable

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT * FROM questions WHERE id = :id
    SQL
    Question.new(data.first)
  end

  def self.find_by_title(title)
    data = QuestionsDatabase.instance.execute(<<-SQL, title: title)
      SELECT * FROM questions WHERE title = :title
    SQL
    result = []
    data.each do |datum|
      result << Question.new(datum)
    end
    result
  end

  def self.find_by_author_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT * FROM questions WHERE user_id = :user_id
    SQL
    result = []
    data.each do |datum|
      result << Question.new(datum)
    end
    result
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_accessor :title, :body, :user_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end
