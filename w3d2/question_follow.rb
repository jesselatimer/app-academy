class QuestionFollow
  # CREATE TABLE question_follows (
  #   id INTEGER PRIMARY KEY,
  #   user_id INTEGER NOT NULL,
  #   question_id INTEGER NOT NULL,
  #   FOREIGN KEY (user_id) REFERENCES users(id),
  #   FOREIGN KEY (question_id) REFERENCES questions(id)
  # );

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        users.id
      FROM
        question_follows
      INNER JOIN
        users ON question_follows.user_id = users.id
      WHERE
        question_id = :question_id
    SQL
    result = data.each_with_object([]) do |id, a|
      id = id["id"]
      a << User.find_by_id(id)
    end
    result
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        questions.id
      FROM
        question_follows
      INNER JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = :user_id
    SQL
    result = []
    data.each do |id|
      id = id["id"]
      result << Question.find_by_id(id)
    end
    result
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        question_follows.question_id
      FROM
        question_follows
      GROUP BY
        question_id
      ORDER BY
        COUNT(user_id) DESC
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
