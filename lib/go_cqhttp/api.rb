# frozen_string_literal: true

module GoCQHTTP
  # API Document: https://docs.go-cqhttp.org/api/
  #
  # Admin API Document: https://docs.go-cqhttp.org/guide/adminApi.html
  module API
    INFO = {
      "send_private_msg" => "post",
      "send_group_msg" => "post",
      "send_group_forward_msg" => "post",
      "send_msg" => "post",
      "delete_msg" => "post",
      "get_msg" => "get",
      "get_forward_msg" => "get",
      "get_image" => "get",
      "set_group_kick" => "post",
      "set_group_ban" => "post",
      "set_group_anonymous_ban" => "post",
      "set_group_whole_ban" => "post",
      "set_group_admin" => "post",
      "set_group_anonymous" => "post",
      "set_group_card" => "post",
      "set_group_name" => "post",
      "set_group_leave" => "post",
      "set_group_special_title" => "post",
      "set_friend_add_request" => "post",
      "set_group_add_request" => "post",
      "get_login_info" => "get",
      "qidian_get_account_info" => "get",
      "get_stranger_info" => "get",
      "get_friend_list" => "get",
      "delete_friend" => "post",
      "get_group_info" => "get",
      "get_group_list" => "get",
      "get_group_member_info" => "get",
      "get_group_member_list" => "get",
      "get_group_honor_info" => "get",
      "get_cookies" => "get",
      "get_csrf_token" => "get",
      "get_credentials" => "get",
      "get_record" => "get",
      "can_send_image" => "get",
      "can_send_record" => "get",
      "get_version_info" => "get",
      "set_restart" => "post",
      "clean_cache" => "post",
      "set_group_portrait" => "post",
      ".get_word_slices" => "post",
      "ocr_image" => "post",
      "get_group_system_msg" => "get",
      "upload_group_file" => "post",
      "get_group_file_system_info" => "get",
      "get_group_root_files" => "get",
      "get_group_files_by_folder" => "get",
      "get_group_file_url" => "get",
      "get_status" => "get",
      "get_group_at_all_remain" => "get",
      ".handle_quick_operation" => "post",
      "_get_vip_info" => "get",
      "_send_group_notice" => "post",
      "reload_event_filter" => "post",
      "download_file" => "post",
      "get_online_clients" => "get",
      "get_group_msg_history" => "get",
      "set_essence_msg" => "post",
      "delete_essence_msg" => "post",
      "get_essence_msg_list" => "get",
      "check_url_safely" => "post",
      "_get_model_show" => "get",
      "_set_model_show" => "post",
      "admin/do_restart" => "post",
      "admin/get_web_write" => "get",
      "admin/do_web_write" => "post",
      "admin/do_restart_docker" => "post",
      "admin/do_process_restart" => "post",
      "admin/do_config_base" => "post",
      "admin/do_config_http" => "post",
      "admin/do_config_ws" => "post",
      "admin/do_config_reverse" => "post",
      "admin/do_config_json" => "post",
      "admin/get_config_json" => "get"
    }.freeze

    def self.existed?(endpoint)
      !!http_method(endpoint)
    end

    def self.list
      INFO.keys
    end

    def self.http_method(endpoint)
      INFO[endpoint.to_s]
    end
  end
end
