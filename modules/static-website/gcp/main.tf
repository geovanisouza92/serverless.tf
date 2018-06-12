resource "google_storage_bucket" "root_domain_bucket" {
  name = "${var.hosting_domain}"

  website {
    main_page_suffix = "${var.content_index}"
    not_found_page   = "${var.content_error}"
  }
}

resource "google_storage_bucket" "www_domain_bucket" {
  name = "${var.alias_domain}"

  website {
    main_page_suffix = "${var.content_index}"
    not_found_page   = "${var.content_error}"
  }
}

# TODO: google cloud cdn

resource "google_dns_managed_zone" "site_zone_config" {
  name     = "${var.name}-site-${var.alias_domain}"
  dns_name = "${var.alias_domain}"
}

resource "google_dns_record_set" "size_domain_config" {
  managed_zone = "${google_dns_managed_zone.site_zone_config.dns_name}"
  name         = "${var.name}-site-${var.alias_domain}"
  type         = "A"
  ttl          = "300"

  # TODO: google cloud cdn
  rrdatas = ["${google_storage_bucket.root_domain_bucket.url}"]
}
