module AllCapsParams
  extend ActiveSupport::Concern

  included do
    if self.respond_to?(:before_action)
      before_action :downcase_all_caps_params, only: :index
    end
  end

  private

  def downcase_all_caps_params
    downcase_all_caps_param params, :q

    params[:clause]&.each do |key, clause_hash|
      downcase_all_caps_param clause_hash, :query
    end
  end

  def downcase_all_caps_param hash, key
    return unless hash[key].present?

    query = hash[key]

    if query.upcase == query
      hash[key] = query.downcase
    end
  end
end
