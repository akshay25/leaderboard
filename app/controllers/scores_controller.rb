class ScoresController < ApplicationController

  def global_leaderboard
    users = user_score.select('users.id, users.name, scores.points').order('scores.points DESC').limit(params[:top_count]).collect do |user|
      {
        id: user.id,
        name: user.name,
        score: user.score.points
      }
    end
    response_formatter(users, {message: "Top #{params[:top_count]} users"}, 200)
  end

  def user_leaderboard
    cur_user = Score.where(user_id: params[:user_id]).first
    cur_user = user_score.select('users.id, users.name, scores.points').where('users.id = ?', params[:user_id]).collect do |user|
      {
        id: user.id,
        name: user.name,
        score: user.score.points
      }
    end.first
    if cur_user.present?
      users_above_cur = user_score.select('users.id, users.name, scores.points').where('scores.points > ?', cur_user[:score]).order('scores.points ASC').limit(params[:set_count]).collect do |user|
        {
          id: user.id,
          name: user.name,
          score: user.score.points
        }
      end
      users_below_cur = user_score.select('users.id, users.name, scores.points').where('scores.points <= ?', cur_user[:score]).order('scores.points DESC').limit(params[:set_count]).collect do |user|
        {
          id: user.id,
          name: user.name,
          score: user.score.points
        }
      end
      result = users_above_cur.reverse + [cur_user] + users_below_cur
      response_formatter(result.flatten, {message: 'users score board'}, 200)
    else
      response_formatter([], {message: 'User not found'}, 400)
    end
  end

  private

  def user_score
    User.joins("INNER JOIN scores ON users.id == scores.user_id")
  end

end
