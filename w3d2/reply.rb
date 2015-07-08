class Reply
  # CREATE TABLE replies (
  #   id INTEGER PRIMARY KEY,
  #   question_id INTEGER NOT NULL,
  #   parent_id INTEGER,
  #   user_id INTEGER NOT NULL,
  #   FOREIGN KEY (question_id) REFERENCES questions(id),
  #   FOREIGN KEY (parent_id) REFERENCES replies(id),
  #   FOREIGN KEY (user_id) REFERENCES users(id)
  # );
  include Saveable

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT * FROM replies WHERE id = :id
    SQL
    Reply.new(data.first)
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT * FROM replies WHERE user_id = :user_id
    SQL
    result = []
    data.each do |datum|
      result << Reply.new(datum)
    end
    result
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT * FROM replies WHERE question_id = :question_id
    SQL
    result = []
    data.each do |datum|
      result << Reply.new(datum)
    end
    result
  end

  def self.find_by_parent_id(parent_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, parent_id: parent_id)
      SELECT * FROM replies WHERE parent_id = :parent_id
    SQL
    result = []
    data.each do |datum|
      result << Reply.new(datum)
    end
    result
  end

  attr_accessor :user_id, :parent_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
    @question_id = options['question_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(@id)
  end
end
