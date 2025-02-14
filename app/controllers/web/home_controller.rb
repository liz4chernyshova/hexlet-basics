# frozen_string_literal: true

class Web::HomeController < Web::ApplicationController
  def index
    @languages_in_development = Language.with_progress(:in_development).includes(:current_version)
    @language_members_by_language = current_user.language_members.index_by(&:language_id)

    @js_course = Language.find_by slug: 'javascript'
    @html_course = Language.find_by slug: 'html'

    @user = User::SignUpForm.new
    @users_count = User.count

    @blog_posts = BlogPost.published.last(2)

    @languages_links_by_slug = Language.all.each_with_object({}) do |item, acc|
      acc[item.slug.to_sym] = view_context.link_to(item, language_path(item.slug))
    end

    @categories = Language::Category.all

    gon.languages_for_widget = helpers.completed_languages.map(&:name)

    seo_tags = {
      title: t('.title'),
      description: t('.meta_description'),
      canonical: root_url,
      image_src: view_context.asset_url('logo.png'),
      twitter: {
        card: 'summary',
        site: '@hexlet_io'
      },
      og: {
        title: t('.title'),
        type: 'website',
        url: root_url,
        image: view_context.asset_url('logo.png')
      }
    }
    set_meta_tags seo_tags
  end

  def robots
    respond_to :text
  end
end
