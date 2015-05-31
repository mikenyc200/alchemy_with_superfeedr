module ApplicationHelper
  def concepts_hash
    concepts_hash = Concept.where("created_at > ?",Time.now-7.days).group(:text).order('count_id desc').count('id')

    result = {}

    concepts_hash.each do |k,v|
      result[k+"("+v.to_s+")"] = k
    end

    result
  end
end
