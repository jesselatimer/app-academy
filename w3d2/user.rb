require_relative 'save'

class User
  # CREATE TABLE users (
  #   id INTEGER PRIMARY KEY,
  #   fname VARCHAR(255) NOT NULL,
  #   lname VARCHAR(255) NOT NULL
  # );

  include Saveable

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT * FROM users WHERE id = :id
    SQL
    # if you do Users.new(data) then you get an array of hashes and a TypeError: no implicit conversion of String into Integer
    User.new(data.first)
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname: lname)
      SELECT * FROM users WHERE fname = :fname and lname = :lname
    SQL
    result = []
    data.each do |datum|
      result << User.new(datum)
    end
    result
  end

  attr_accessor :fname, :lname

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  # def average_karma
  #   count = 0
  #   sum = 0
  #   authored_questions.each do |question|
  #     sum += question.num_likes
  #     count += 1
  #   end
  #   return 0 if count == 0
  #   sum / count
  # end

  def average_karma
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        CAST(COUNT(question_likes.id) as FLOAT) / CAST(COUNT(DISTINCT questions.id) as FLOAT)
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.user_id = #{@id}
    SQL
    data.first.values[0]
  end


  # def save
    # if @id.nil?
    #   data = QuestionsDatabase.instance.execute(<<-SQL, fname: f_name, lname: l_name)
    #     INSERT INTO
    #       users (fname, lname)
    #     VALUES
    #       (:fname, :lname)
    #   SQL
    #   @id = QuestionsDatabase.instance.last_insert_row_id
    # else
    #   data = QuestionsDatabase.instance.execute(<<-SQL, fname: f_name, lname: l_name)
    #     UPDATE
    #       users
    #     SET
    #       fname = :fname, lname = :lname
    #     WHERE
    #       id = #{@id}
    #   SQL
    # end
  # end

end
