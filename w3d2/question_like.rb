class QuestionLike
# CREATE TABLE question_likes (
#   id INTEGER PRIMARY KEY,
#   user_id INTEGER NOT NULL,
#   question_id INTEGER NOT NULL,
#   FOREIGN KEY (user_id) REFERENCES users(id),
#   FOREIGN KEY (question_id) REFERENCES questions(id)
# );
  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        users.id
      FROM
        question_likes
      INNER JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_id = :question_id
    SQL
    result = []
    data.each do |id|
      id = id["id"]
      result << User.find_by_id(id)
    end
    result
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        questions.id
      FROM
        question_likes
      INNER JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = :user_id
    SQL
    result = []
    data.each do |id|
      id = id["id"]
      result << Question.find_by_id(id)
    end
    result
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = :question_id
    SQL
    data[0].values.first
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        question_likes.question_id
      FROM
        question_likes
      GROUP BY question_id
      ORDER BY count(user_id) desc
      LIMIT :n
    SQL
    result = []
    data.each do |id|
      puts id
      id = id["question_id"]
      result << Question.find_by_id(id)
    end
    result
  end

end
