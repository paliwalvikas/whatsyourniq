# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


module Google
  module Container
    module V1beta1
      # Parameters that describe the nodes in a cluster.
      # @!attribute [rw] machine_type
      #   @return [String]
      #     The name of a Google Compute Engine [machine
      #     type](https://cloud.google.com/compute/docs/machine-types) (e.g.
      #     `n1-standard-1`).
      #
      #     If unspecified, the default machine type is
      #     `n1-standard-1`.
      # @!attribute [rw] disk_size_gb
      #   @return [Integer]
      #     Size of the disk attached to each node, specified in GB.
      #     The smallest allowed disk size is 10GB.
      #
      #     If unspecified, the default disk size is 100GB.
      # @!attribute [rw] oauth_scopes
      #   @return [Array<String>]
      #     The set of Google API scopes to be made available on all of the
      #     node VMs under the "default" service account.
      #
      #     The following scopes are recommended, but not required, and by default are
      #     not included:
      #
      #     * `https://www.googleapis.com/auth/compute` is required for mounting
      #       persistent storage on your nodes.
      #     * `https://www.googleapis.com/auth/devstorage.read_only` is required for
      #       communicating with **gcr.io**
      #       (the [Google Container Registry](https://cloud.google.com/container-registry/)).
      #
      #     If unspecified, no scopes are added, unless Cloud Logging or Cloud
      #     Monitoring are enabled, in which case their required scopes will be added.
      # @!attribute [rw] service_account
      #   @return [String]
      #     The Google Cloud Platform Service Account to be used by the node VMs. If
      #     no Service Account is specified, the "default" service account is used.
      # @!attribute [rw] metadata
      #   @return [Hash{String => String}]
      #     The metadata key/value pairs assigned to instances in the cluster.
      #
      #     Keys must conform to the regexp [a-zA-Z0-9-_]+ and be less than 128 bytes
      #     in length. These are reflected as part of a URL in the metadata server.
      #     Additionally, to avoid ambiguity, keys must not conflict with any other
      #     metadata keys for the project or be one of the reserved keys:
      #      "cluster-location"
      #      "cluster-name"
      #      "cluster-uid"
      #      "configure-sh"
      #      "containerd-configure-sh"
      #      "enable-oslogin"
      #      "gci-ensure-gke-docker"
      #      "gci-metrics-enabled"
      #      "gci-update-strategy"
      #      "instance-template"
      #      "kube-env"
      #      "startup-script"
      #      "user-data"
      #      "disable-address-manager"
      #      "windows-startup-script-ps1"
      #      "common-psm1"
      #      "k8s-node-setup-psm1"
      #      "install-ssh-psm1"
      #      "user-profile-psm1"
      #      "serial-port-logging-enable"
      #     Values are free-form strings, and only have meaning as interpreted by
      #     the image running in the instance. The only restriction placed on them is
      #     that each value's size must be less than or equal to 32 KB.
      #
      #     The total size of all keys and values must be less than 512 KB.
      # @!attribute [rw] image_type
      #   @return [String]
      #     The image type to use for this node. Note that for a given image type,
      #     the latest version of it will be used.
      # @!attribute [rw] labels
      #   @return [Hash{String => String}]
      #     The map of Kubernetes labels (key/value pairs) to be applied to each node.
      #     These will added in addition to any default label(s) that
      #     Kubernetes may apply to the node.
      #     In case of conflict in label keys, the applied set may differ depending on
      #     the Kubernetes version -- it's best to assume the behavior is undefined
      #     and conflicts should be avoided.
      #     For more information, including usage and the valid values, see:
      #     https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
      # @!attribute [rw] local_ssd_count
      #   @return [Integer]
      #     The number of local SSD disks to be attached to the node.
      #
      #     The limit for this value is dependent upon the maximum number of
      #     disks available on a machine per zone. See:
      #     https://cloud.google.com/compute/docs/disks/local-ssd
      #     for more information.
      # @!attribute [rw] tags
      #   @return [Array<String>]
      #     The list of instance tags applied to all nodes. Tags are used to identify
      #     valid sources or targets for network firewalls and are specified by
      #     the client during cluster or node pool creation. Each tag within the list
      #     must comply with RFC1035.
      # @!attribute [rw] preemptible
      #   @return [true, false]
      #     Whether the nodes are created as preemptible VM instances. See:
      #     https://cloud.google.com/compute/docs/instances/preemptible for more
      #     inforamtion about preemptible VM instances.
      # @!attribute [rw] accelerators
      #   @return [Array<Google::Container::V1beta1::AcceleratorConfig>]
      #     A list of hardware accelerators to be attached to each node.
      #     See https://cloud.google.com/compute/docs/gpus for more information about
      #     support for GPUs.
      # @!attribute [rw] disk_type
      #   @return [String]
      #     Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd')
      #
      #     If unspecified, the default disk type is 'pd-standard'
      # @!attribute [rw] min_cpu_platform
      #   @return [String]
      #     Minimum CPU platform to be used by this instance. The instance may be
      #     scheduled on the specified or newer CPU platform. Applicable values are the
      #     friendly names of CPU platforms, such as
      #     <code>minCpuPlatform: &quot;Intel Haswell&quot;</code> or
      #     <code>minCpuPlatform: &quot;Intel Sandy Bridge&quot;</code>. For more
      #     information, read [how to specify min CPU
      #     platform](https://cloud.google.com/compute/docs/instances/specify-min-cpu-platform)
      #     To unset the min cpu platform field pass "automatic" as field value.
      # @!attribute [rw] workload_metadata_config
      #   @return [Google::Container::V1beta1::WorkloadMetadataConfig]
      #     The workload metadata configuration for this node.
      # @!attribute [rw] taints
      #   @return [Array<Google::Container::V1beta1::NodeTaint>]
      #     List of kubernetes taints to be applied to each node.
      #
      #     For more information, including usage and the valid values, see:
      #     https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
      # @!attribute [rw] shielded_instance_config
      #   @return [Google::Container::V1beta1::ShieldedInstanceConfig]
      #     Shielded Instance options.
      class NodeConfig; end

      # A set of Shielded Instance options.
      # @!attribute [rw] enable_secure_boot
      #   @return [true, false]
      #     Defines whether the instance has Secure Boot enabled.
      #
      #     Secure Boot helps ensure that the system only runs authentic software by
      #     verifying the digital signature of all boot components, and halting the
      #     boot process if signature verification fails.
      # @!attribute [rw] enable_integrity_monitoring
      #   @return [true, false]
      #     Defines whether the instance has integrity monitoring enabled.
      #
      #     Enables monitoring and attestation of the boot integrity of the instance.
      #     The attestation is performed against the integrity policy baseline. This
      #     baseline is initially derived from the implicitly trusted boot image when
      #     the instance is created.
      class ShieldedInstanceConfig; end

      # Kubernetes taint is comprised of three fields: key, value, and effect. Effect
      # can only be one of three types:  NoSchedule, PreferNoSchedule or NoExecute.
      #
      # For more information, including usage and the valid values, see:
      # https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
      # @!attribute [rw] key
      #   @return [String]
      #     Key for taint.
      # @!attribute [rw] value
      #   @return [String]
      #     Value for taint.
      # @!attribute [rw] effect
      #   @return [Google::Container::V1beta1::NodeTaint::Effect]
      #     Effect for taint.
      class NodeTaint
        # Possible values for Effect in taint.
        module Effect
          # Not set
          EFFECT_UNSPECIFIED = 0

          # NoSchedule
          NO_SCHEDULE = 1

          # PreferNoSchedule
          PREFER_NO_SCHEDULE = 2

          # NoExecute
          NO_EXECUTE = 3
        end
      end

      # The authentication information for accessing the master endpoint.
      # Authentication can be done using HTTP basic auth or using client
      # certificates.
      # @!attribute [rw] username
      #   @return [String]
      #     The username to use for HTTP basic authentication to the master endpoint.
      #     For clusters v1.6.0 and later, basic authentication can be disabled by
      #     leaving username unspecified (or setting it to the empty string).
      # @!attribute [rw] password
      #   @return [String]
      #     The password to use for HTTP basic authentication to the master endpoint.
      #     Because the master endpoint is open to the Internet, you should create a
      #     strong password.  If a password is provided for cluster creation, username
      #     must be non-empty.
      # @!attribute [rw] client_certificate_config
      #   @return [Google::Container::V1beta1::ClientCertificateConfig]
      #     Configuration for client certificate authentication on the cluster. For
      #     clusters before v1.12, if no configuration is specified, a client
      #     certificate is issued.
      # @!attribute [rw] cluster_ca_certificate
      #   @return [String]
      #     [Output only] Base64-encoded public certificate that is the root of
      #     trust for the cluster.
      # @!attribute [rw] client_certificate
      #   @return [String]
      #     [Output only] Base64-encoded public certificate used by clients to
      #     authenticate to the cluster endpoint.
      # @!attribute [rw] client_key
      #   @return [String]
      #     [Output only] Base64-encoded private key used by clients to authenticate
      #     to the cluster endpoint.
      class MasterAuth; end

      # Configuration for client certificates on the cluster.
      # @!attribute [rw] issue_client_certificate
      #   @return [true, false]
      #     Issue a client certificate.
      class ClientCertificateConfig; end

      # Configuration for the addons that can be automatically spun up in the
      # cluster, enabling additional functionality.
      # @!attribute [rw] http_load_balancing
      #   @return [Google::Container::V1beta1::HttpLoadBalancing]
      #     Configuration for the HTTP (L7) load balancing controller addon, which
      #     makes it easy to set up HTTP load balancers for services in a cluster.
      # @!attribute [rw] horizontal_pod_autoscaling
      #   @return [Google::Container::V1beta1::HorizontalPodAutoscaling]
      #     Configuration for the horizontal pod autoscaling feature, which
      #     increases or decreases the number of replica pods a replication controller
      #     has based on the resource usage of the existing pods.
      # @!attribute [rw] kubernetes_dashboard
      #   @return [Google::Container::V1beta1::KubernetesDashboard]
      #     Configuration for the Kubernetes Dashboard.
      #     This addon is deprecated, and will be disabled in 1.15. It is recommended
      #     to use the Cloud Console to manage and monitor your Kubernetes clusters,
      #     workloads and applications. For more information, see:
      #     https://cloud.google.com/kubernetes-engine/docs/concepts/dashboards
      # @!attribute [rw] network_policy_config
      #   @return [Google::Container::V1beta1::NetworkPolicyConfig]
      #     Configuration for NetworkPolicy. This only tracks whether the addon
      #     is enabled or not on the Master, it does not track whether network policy
      #     is enabled for the nodes.
      # @!attribute [rw] istio_config
      #   @return [Google::Container::V1beta1::IstioConfig]
      #     Configuration for Istio, an open platform to connect, manage, and secure
      #     microservices.
      # @!attribute [rw] cloud_run_config
      #   @return [Google::Container::V1beta1::CloudRunConfig]
      #     Configuration for the Cloud Run addon. The `IstioConfig` addon must be
      #     enabled in order to enable Cloud Run addon. This option can only be enabled
      #     at cluster creation time.
      class AddonsConfig; end

      # Configuration options for the HTTP (L7) load balancing controller addon,
      # which makes it easy to set up HTTP load balancers for services in a cluster.
      # @!attribute [rw] disabled
      #   @return [true, false]
      #     Whether the HTTP Load Balancing controller is enabled in the cluster.
      #     When enabled, it runs a small pod in the cluster that manages the load
      #     balancers.
      class HttpLoadBalancing; end

      # Configuration options for the horizontal pod autoscaling feature, which
      # increases or decreases the number of replica pods a replication controller
      # has based on the resource usage of the existing pods.
      # @!attribute [rw] disabled
      #   @return [true, false]
      #     Whether the Horizontal Pod Autoscaling feature is enabled in the cluster.
      #     When enabled, it ensures that a Heapster pod is running in the cluster,
      #     which is also used by the Cloud Monitoring service.
      class HorizontalPodAutoscaling; end

      # Configuration for the Kubernetes Dashboard.
      # @!attribute [rw] disabled
      #   @return [true, false]
      #     Whether the Kubernetes Dashboard is enabled for this cluster.
      class KubernetesDashboard; end

      # Configuration for NetworkPolicy. This only tracks whether the addon
      # is enabled or not on the Master, it does not track whether network policy
      # is enabled for the nodes.
      # @!attribute [rw] disabled
      #   @return [true, false]
      #     Whether NetworkPolicy is enabled for this cluster.
      class NetworkPolicyConfig; end

      # Configuration options for private clusters.
      # @!attribute [rw] enable_private_nodes
      #   @return [true, false]
      #     Whether nodes have internal IP addresses only. If enabled, all nodes are
      #     given only RFC 1918 private addresses and communicate with the master via
      #     private networking.
      # @!attribute [rw] enable_private_endpoint
      #   @return [true, false]
      #     Whether the master's internal IP address is used as the cluster endpoint.
      # @!attribute [rw] master_ipv4_cidr_block
      #   @return [String]
      #     The IP range in CIDR notation to use for the hosted master network. This
      #     range will be used for assigning internal IP addresses to the master or
      #     set of masters, as well as the ILB VIP. This range must not overlap with
      #     any other ranges in use within the cluster's network.
      # @!attribute [rw] private_endpoint
      #   @return [String]
      #     Output only. The internal IP address of this cluster's master endpoint.
      # @!attribute [rw] public_endpoint
      #   @return [String]
      #     Output only. The external IP address of this cluster's master endpoint.
      class PrivateClusterConfig; end

      # Configuration options for Istio addon.
      # @!attribute [rw] disabled
      #   @return [true, false]
      #     Whether Istio is enabled for this cluster.
      # @!attribute [rw] auth
      #   @return [Google::Container::V1beta1::IstioConfig::IstioAuthMode]
      #     The specified Istio auth mode, either none, or mutual TLS.
      class IstioConfig
        # Istio auth mode, https://istio.io/docs/concepts/security/mutual-tls.html
        module IstioAuthMode
          # auth not enabled
          AUTH_NONE = 0

          # auth mutual TLS enabled
          AUTH_MUTUAL_TLS = 1
        end
      end

      # Configuration options for the Cloud Run feature.
      # @!attribute [rw] disabled
      #   @return [true, false]
      #     Whether Cloud Run addon is enabled for this cluster.
      class CloudRunConfig; end

      # Configuration options for the master authorized networks feature. Enabled
      # master authorized networks will disallow all external traffic to access
      # Kubernetes master through HTTPS except traffic from the given CIDR blocks,
      # Google Compute Engine Public IPs and Google Prod IPs.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Whether or not master authorized networks is enabled.
      # @!attribute [rw] cidr_blocks
      #   @return [Array<Google::Container::V1beta1::MasterAuthorizedNetworksConfig::CidrBlock>]
      #     cidr_blocks define up to 10 external networks that could access
      #     Kubernetes master through HTTPS.
      class MasterAuthorizedNetworksConfig
        # CidrBlock contains an optional name and one CIDR block.
        # @!attribute [rw] display_name
        #   @return [String]
        #     display_name is an optional field for users to identify CIDR blocks.
        # @!attribute [rw] cidr_block
        #   @return [String]
        #     cidr_block must be specified in CIDR notation.
        class CidrBlock; end
      end

      # Configuration for the legacy Attribute Based Access Control authorization
      # mode.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Whether the ABAC authorizer is enabled for this cluster. When enabled,
      #     identities in the system, including service accounts, nodes, and
      #     controllers, will have statically granted permissions beyond those
      #     provided by the RBAC configuration or IAM.
      class LegacyAbac; end

      # Configuration options for the NetworkPolicy feature.
      # https://kubernetes.io/docs/concepts/services-networking/networkpolicies/
      # @!attribute [rw] provider
      #   @return [Google::Container::V1beta1::NetworkPolicy::Provider]
      #     The selected network policy provider.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Whether network policy is enabled on the cluster.
      class NetworkPolicy
        # Allowed Network Policy providers.
        module Provider
          # Not set
          PROVIDER_UNSPECIFIED = 0

          # Tigera (Calico Felix).
          CALICO = 1
        end
      end

      # Configuration for controlling how IPs are allocated in the cluster.
      # @!attribute [rw] use_ip_aliases
      #   @return [true, false]
      #     Whether alias IPs will be used for pod IPs in the cluster.
      # @!attribute [rw] create_subnetwork
      #   @return [true, false]
      #     Whether a new subnetwork will be created automatically for the cluster.
      #
      #     This field is only applicable when `use_ip_aliases` is true.
      # @!attribute [rw] subnetwork_name
      #   @return [String]
      #     A custom subnetwork name to be used if `create_subnetwork` is true.  If
      #     this field is empty, then an automatic name will be chosen for the new
      #     subnetwork.
      # @!attribute [rw] cluster_ipv4_cidr
      #   @return [String]
      #     This field is deprecated, use cluster_ipv4_cidr_block.
      # @!attribute [rw] node_ipv4_cidr
      #   @return [String]
      #     This field is deprecated, use node_ipv4_cidr_block.
      # @!attribute [rw] services_ipv4_cidr
      #   @return [String]
      #     This field is deprecated, use services_ipv4_cidr_block.
      # @!attribute [rw] cluster_secondary_range_name
      #   @return [String]
      #     The name of the secondary range to be used for the cluster CIDR
      #     block.  The secondary range will be used for pod IP
      #     addresses. This must be an existing secondary range associated
      #     with the cluster subnetwork.
      #
      #     This field is only applicable with use_ip_aliases and
      #     create_subnetwork is false.
      # @!attribute [rw] services_secondary_range_name
      #   @return [String]
      #     The name of the secondary range to be used as for the services
      #     CIDR block.  The secondary range will be used for service
      #     ClusterIPs. This must be an existing secondary range associated
      #     with the cluster subnetwork.
      #
      #     This field is only applicable with use_ip_aliases and
      #     create_subnetwork is false.
      # @!attribute [rw] cluster_ipv4_cidr_block
      #   @return [String]
      #     The IP address range for the cluster pod IPs. If this field is set, then
      #     `cluster.cluster_ipv4_cidr` must be left blank.
      #
      #     This field is only applicable when `use_ip_aliases` is true.
      #
      #     Set to blank to have a range chosen with the default size.
      #
      #     Set to /netmask (e.g. `/14`) to have a range chosen with a specific
      #     netmask.
      #
      #     Set to a
      #     [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
      #     notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g.
      #     `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range
      #     to use.
      # @!attribute [rw] node_ipv4_cidr_block
      #   @return [String]
      #     The IP address range of the instance IPs in this cluster.
      #
      #     This is applicable only if `create_subnetwork` is true.
      #
      #     Set to blank to have a range chosen with the default size.
      #
      #     Set to /netmask (e.g. `/14`) to have a range chosen with a specific
      #     netmask.
      #
      #     Set to a
      #     [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
      #     notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g.
      #     `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range
      #     to use.
      # @!attribute [rw] services_ipv4_cidr_block
      #   @return [String]
      #     The IP address range of the services IPs in this cluster. If blank, a range
      #     will be automatically chosen with the default size.
      #
      #     This field is only applicable when `use_ip_aliases` is true.
      #
      #     Set to blank to have a range chosen with the default size.
      #
      #     Set to /netmask (e.g. `/14`) to have a range chosen with a specific
      #     netmask.
      #
      #     Set to a
      #     [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
      #     notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g.
      #     `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range
      #     to use.
      # @!attribute [rw] allow_route_overlap
      #   @return [true, false]
      #     If true, allow allocation of cluster CIDR ranges that overlap with certain
      #     kinds of network routes. By default we do not allow cluster CIDR ranges to
      #     intersect with any user declared routes. With allow_route_overlap == true,
      #     we allow overlapping with CIDR ranges that are larger than the cluster CIDR
      #     range.
      #
      #     If this field is set to true, then cluster and services CIDRs must be
      #     fully-specified (e.g. `10.96.0.0/14`, but not `/14`), which means:
      #     1) When `use_ip_aliases` is true, `cluster_ipv4_cidr_block` and
      #        `services_ipv4_cidr_block` must be fully-specified.
      #     2) When `use_ip_aliases` is false, `cluster.cluster_ipv4_cidr` muse be
      #        fully-specified.
      # @!attribute [rw] tpu_ipv4_cidr_block
      #   @return [String]
      #     The IP address range of the Cloud TPUs in this cluster. If unspecified, a
      #     range will be automatically chosen with the default size.
      #
      #     This field is only applicable when `use_ip_aliases` is true.
      #
      #     If unspecified, the range will use the default size.
      #
      #     Set to /netmask (e.g. `/14`) to have a range chosen with a specific
      #     netmask.
      #
      #     Set to a
      #     [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
      #     notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g.
      #     `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range
      #     to use.
      class IPAllocationPolicy; end

      # Configuration for Binary Authorization.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Enable Binary Authorization for this cluster. If enabled, all container
      #     images will be validated by Google Binauthz.
      class BinaryAuthorization; end

      # Configuration for the PodSecurityPolicy feature.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Enable the PodSecurityPolicy controller for this cluster. If enabled, pods
      #     must be valid under a PodSecurityPolicy to be created.
      class PodSecurityPolicyConfig; end

      # Configuration for returning group information from authenticators.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Whether this cluster should return group membership lookups
      #     during authentication using a group of security groups.
      # @!attribute [rw] security_group
      #   @return [String]
      #     The name of the security group-of-groups to be used. Only relevant
      #     if enabled = true.
      class AuthenticatorGroupsConfig; end

      # A Google Kubernetes Engine cluster.
      # @!attribute [rw] name
      #   @return [String]
      #     The name of this cluster. The name must be unique within this project
      #     and location (e.g. zone or region), and can be up to 40 characters with
      #     the following restrictions:
      #
      #     * Lowercase letters, numbers, and hyphens only.
      #     * Must start with a letter.
      #     * Must end with a number or a letter.
      # @!attribute [rw] description
      #   @return [String]
      #     An optional description of this cluster.
      # @!attribute [rw] initial_node_count
      #   @return [Integer]
      #     The number of nodes to create in this cluster. You must ensure that your
      #     Compute Engine <a href="/compute/docs/resource-quotas">resource quota</a>
      #     is sufficient for this number of instances. You must also have available
      #     firewall and routes quota.
      #     For requests, this field should only be used in lieu of a
      #     "node_pool" object, since this configuration (along with the
      #     "node_config") will be used to create a "NodePool" object with an
      #     auto-generated name. Do not use this and a node_pool at the same time.
      #
      #     This field is deprecated, use node_pool.initial_node_count instead.
      # @!attribute [rw] node_config
      #   @return [Google::Container::V1beta1::NodeConfig]
      #     Parameters used in creating the cluster's nodes.
      #     For requests, this field should only be used in lieu of a
      #     "node_pool" object, since this configuration (along with the
      #     "initial_node_count") will be used to create a "NodePool" object with an
      #     auto-generated name. Do not use this and a node_pool at the same time.
      #     For responses, this field will be populated with the node configuration of
      #     the first node pool. (For configuration of each node pool, see
      #     `node_pool.config`)
      #
      #     If unspecified, the defaults are used.
      #     This field is deprecated, use node_pool.config instead.
      # @!attribute [rw] master_auth
      #   @return [Google::Container::V1beta1::MasterAuth]
      #     The authentication information for accessing the master endpoint.
      #     If unspecified, the defaults are used:
      #     For clusters before v1.12, if master_auth is unspecified, `username` will
      #     be set to "admin", a random password will be generated, and a client
      #     certificate will be issued.
      # @!attribute [rw] logging_service
      #   @return [String]
      #     The logging service the cluster should use to write logs.
      #     Currently available options:
      #
      #     * `logging.googleapis.com` - the Google Cloud Logging service.
      #     * `none` - no logs will be exported from the cluster.
      #     * if left as an empty string,`logging.googleapis.com` will be used.
      # @!attribute [rw] monitoring_service
      #   @return [String]
      #     The monitoring service the cluster should use to write metrics.
      #     Currently available options:
      #
      #     * `monitoring.googleapis.com` - the Google Cloud Monitoring service.
      #     * `none` - no metrics will be exported from the cluster.
      #     * if left as an empty string, `monitoring.googleapis.com` will be used.
      # @!attribute [rw] network
      #   @return [String]
      #     The name of the Google Compute Engine
      #     [network](https://cloud.google.com/compute/docs/networks-and-firewalls#networks) to which the
      #     cluster is connected. If left unspecified, the `default` network
      #     will be used. On output this shows the network ID instead of
      #     the name.
      # @!attribute [rw] cluster_ipv4_cidr
      #   @return [String]
      #     The IP address range of the container pods in this cluster, in
      #     [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
      #     notation (e.g. `10.96.0.0/14`). Leave blank to have
      #     one automatically chosen or specify a `/14` block in `10.0.0.0/8`.
      # @!attribute [rw] addons_config
      #   @return [Google::Container::V1beta1::AddonsConfig]
      #     Configurations for the various addons available to run in the cluster.
      # @!attribute [rw] subnetwork
      #   @return [String]
      #     The name of the Google Compute Engine
      #     [subnetwork](https://cloud.google.com/compute/docs/subnetworks) to which the
      #     cluster is connected. On output this shows the subnetwork ID instead of
      #     the name.
      # @!attribute [rw] node_pools
      #   @return [Array<Google::Container::V1beta1::NodePool>]
      #     The node pools associated with this cluster.
      #     This field should not be set if "node_config" or "initial_node_count" are
      #     specified.
      # @!attribute [rw] locations
      #   @return [Array<String>]
      #     The list of Google Compute Engine
      #     [zones](https://cloud.google.com/compute/docs/zones#available) in which the cluster's nodes
      #     should be located.
      # @!attribute [rw] enable_kubernetes_alpha
      #   @return [true, false]
      #     Kubernetes alpha features are enabled on this cluster. This includes alpha
      #     API groups (e.g. v1beta1) and features that may not be production ready in
      #     the kubernetes version of the master and nodes.
      #     The cluster has no SLA for uptime and master/node upgrades are disabled.
      #     Alpha enabled clusters are automatically deleted thirty days after
      #     creation.
      # @!attribute [rw] resource_labels
      #   @return [Hash{String => String}]
      #     The resource labels for the cluster to use to annotate any related
      #     Google Compute Engine resources.
      # @!attribute [rw] label_fingerprint
      #   @return [String]
      #     The fingerprint of the set of labels for this cluster.
      # @!attribute [rw] legacy_abac
      #   @return [Google::Container::V1beta1::LegacyAbac]
      #     Configuration for the legacy ABAC authorization mode.
      # @!attribute [rw] network_policy
      #   @return [Google::Container::V1beta1::NetworkPolicy]
      #     Configuration options for the NetworkPolicy feature.
      # @!attribute [rw] ip_allocation_policy
      #   @return [Google::Container::V1beta1::IPAllocationPolicy]
      #     Configuration for cluster IP allocation.
      # @!attribute [rw] master_authorized_networks_config
      #   @return [Google::Container::V1beta1::MasterAuthorizedNetworksConfig]
      #     The configuration options for master authorized networks feature.
      # @!attribute [rw] maintenance_policy
      #   @return [Google::Container::V1beta1::MaintenancePolicy]
      #     Configure the maintenance policy for this cluster.
      # @!attribute [rw] binary_authorization
      #   @return [Google::Container::V1beta1::BinaryAuthorization]
      #     Configuration for Binary Authorization.
      # @!attribute [rw] pod_security_policy_config
      #   @return [Google::Container::V1beta1::PodSecurityPolicyConfig]
      #     Configuration for the PodSecurityPolicy feature.
      # @!attribute [rw] autoscaling
      #   @return [Google::Container::V1beta1::ClusterAutoscaling]
      #     Cluster-level autoscaling configuration.
      # @!attribute [rw] network_config
      #   @return [Google::Container::V1beta1::NetworkConfig]
      #     Configuration for cluster networking.
      # @!attribute [rw] private_cluster
      #   @return [true, false]
      #     If this is a private cluster setup. Private clusters are clusters that, by
      #     default have no external IP addresses on the nodes and where nodes and the
      #     master communicate over private IP addresses.
      #     This field is deprecated, use private_cluster_config.enable_private_nodes
      #     instead.
      # @!attribute [rw] master_ipv4_cidr_block
      #   @return [String]
      #     The IP prefix in CIDR notation to use for the hosted master network.
      #     This prefix will be used for assigning private IP addresses to the
      #     master or set of masters, as well as the ILB VIP.
      #     This field is deprecated, use
      #     private_cluster_config.master_ipv4_cidr_block instead.
      # @!attribute [rw] default_max_pods_constraint
      #   @return [Google::Container::V1beta1::MaxPodsConstraint]
      #     The default constraint on the maximum number of pods that can be run
      #     simultaneously on a node in the node pool of this cluster. Only honored
      #     if cluster created with IP Alias support.
      # @!attribute [rw] resource_usage_export_config
      #   @return [Google::Container::V1beta1::ResourceUsageExportConfig]
      #     Configuration for exporting resource usages. Resource usage export is
      #     disabled when this config unspecified.
      # @!attribute [rw] authenticator_groups_config
      #   @return [Google::Container::V1beta1::AuthenticatorGroupsConfig]
      #     Configuration controlling RBAC group membership information.
      # @!attribute [rw] private_cluster_config
      #   @return [Google::Container::V1beta1::PrivateClusterConfig]
      #     Configuration for private cluster.
      # @!attribute [rw] vertical_pod_autoscaling
      #   @return [Google::Container::V1beta1::VerticalPodAutoscaling]
      #     Cluster-level Vertical Pod Autoscaling configuration.
      # @!attribute [rw] self_link
      #   @return [String]
      #     [Output only] Server-defined URL for the resource.
      # @!attribute [rw] zone
      #   @return [String]
      #     [Output only] The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field is deprecated, use location instead.
      # @!attribute [rw] endpoint
      #   @return [String]
      #     [Output only] The IP address of this cluster's master endpoint.
      #     The endpoint can be accessed from the internet at
      #     `https://username:password@endpoint/`.
      #
      #     See the `masterAuth` property of this resource for username and
      #     password information.
      # @!attribute [rw] initial_cluster_version
      #   @return [String]
      #     The initial Kubernetes version for this cluster.  Valid versions are those
      #     found in validMasterVersions returned by getServerConfig.  The version can
      #     be upgraded over time; such upgrades are reflected in
      #     currentMasterVersion and currentNodeVersion.
      #
      #     Users may specify either explicit versions offered by
      #     Kubernetes Engine or version aliases, which have the following behavior:
      #
      #     * "latest": picks the highest valid Kubernetes version
      #     * "1.X": picks the highest valid patch+gke.N patch in the 1.X version
      #     * "1.X.Y": picks the highest valid gke.N patch in the 1.X.Y version
      #     * "1.X.Y-gke.N": picks an explicit Kubernetes version
      #     * "","-": picks the default Kubernetes version
      # @!attribute [rw] current_master_version
      #   @return [String]
      #     [Output only] The current software version of the master endpoint.
      # @!attribute [rw] current_node_version
      #   @return [String]
      #     [Output only] Deprecated, use
      #     [NodePool.version](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters.nodePools)
      #     instead. The current version of the node software components.
      #     If they are currently at multiple versions because they're in the process
      #     of being upgraded, this reflects the minimum version of all nodes.
      # @!attribute [rw] create_time
      #   @return [String]
      #     [Output only] The time the cluster was created, in
      #     [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
      # @!attribute [rw] status
      #   @return [Google::Container::V1beta1::Cluster::Status]
      #     [Output only] The current status of this cluster.
      # @!attribute [rw] status_message
      #   @return [String]
      #     [Output only] Additional information about the current status of this
      #     cluster, if available.
      # @!attribute [rw] node_ipv4_cidr_size
      #   @return [Integer]
      #     [Output only] The size of the address space on each node for hosting
      #     containers. This is provisioned from within the `container_ipv4_cidr`
      #     range. This field will only be set when cluster is in route-based network
      #     mode.
      # @!attribute [rw] services_ipv4_cidr
      #   @return [String]
      #     [Output only] The IP address range of the Kubernetes services in
      #     this cluster, in
      #     [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
      #     notation (e.g. `1.2.3.4/29`). Service addresses are
      #     typically put in the last `/16` from the container CIDR.
      # @!attribute [rw] instance_group_urls
      #   @return [Array<String>]
      #     Deprecated. Use node_pools.instance_group_urls.
      # @!attribute [rw] current_node_count
      #   @return [Integer]
      #     [Output only]  The number of nodes currently in the cluster. Deprecated.
      #     Call Kubernetes API directly to retrieve node information.
      # @!attribute [rw] expire_time
      #   @return [String]
      #     [Output only] The time the cluster will be automatically
      #     deleted in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
      # @!attribute [rw] location
      #   @return [String]
      #     [Output only] The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) or
      #     [region](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) in which
      #     the cluster resides.
      # @!attribute [rw] enable_tpu
      #   @return [true, false]
      #     Enable the ability to use Cloud TPUs in this cluster.
      # @!attribute [rw] tpu_ipv4_cidr_block
      #   @return [String]
      #     [Output only] The IP address range of the Cloud TPUs in this cluster, in
      #     [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
      #     notation (e.g. `1.2.3.4/29`).
      # @!attribute [rw] database_encryption
      #   @return [Google::Container::V1beta1::DatabaseEncryption]
      #     Configuration of etcd encryption.
      # @!attribute [rw] conditions
      #   @return [Array<Google::Container::V1beta1::StatusCondition>]
      #     Which conditions caused the current cluster state.
      class Cluster
        # The current status of the cluster.
        module Status
          # Not set.
          STATUS_UNSPECIFIED = 0

          # The PROVISIONING state indicates the cluster is being created.
          PROVISIONING = 1

          # The RUNNING state indicates the cluster has been created and is fully
          # usable.
          RUNNING = 2

          # The RECONCILING state indicates that some work is actively being done on
          # the cluster, such as upgrading the master or node software. Details can
          # be found in the `statusMessage` field.
          RECONCILING = 3

          # The STOPPING state indicates the cluster is being deleted.
          STOPPING = 4

          # The ERROR state indicates the cluster may be unusable. Details
          # can be found in the `statusMessage` field.
          ERROR = 5

          # The DEGRADED state indicates the cluster requires user action to restore
          # full functionality. Details can be found in the `statusMessage` field.
          DEGRADED = 6
        end
      end

      # ClusterUpdate describes an update to the cluster. Exactly one update can
      # be applied to a cluster with each request, so at most one field can be
      # provided.
      # @!attribute [rw] desired_node_version
      #   @return [String]
      #     The Kubernetes version to change the nodes to (typically an
      #     upgrade).
      #
      #     Users may specify either explicit versions offered by
      #     Kubernetes Engine or version aliases, which have the following behavior:
      #
      #     * "latest": picks the highest valid Kubernetes version
      #     * "1.X": picks the highest valid patch+gke.N patch in the 1.X version
      #     * "1.X.Y": picks the highest valid gke.N patch in the 1.X.Y version
      #     * "1.X.Y-gke.N": picks an explicit Kubernetes version
      #     * "-": picks the Kubernetes master version
      # @!attribute [rw] desired_monitoring_service
      #   @return [String]
      #     The monitoring service the cluster should use to write metrics.
      #     Currently available options:
      #
      #     * "monitoring.googleapis.com/kubernetes" - the Google Cloud Monitoring
      #       service with Kubernetes-native resource model
      #     * "monitoring.googleapis.com" - the Google Cloud Monitoring service
      #     * "none" - no metrics will be exported from the cluster
      # @!attribute [rw] desired_addons_config
      #   @return [Google::Container::V1beta1::AddonsConfig]
      #     Configurations for the various addons available to run in the cluster.
      # @!attribute [rw] desired_node_pool_id
      #   @return [String]
      #     The node pool to be upgraded. This field is mandatory if
      #     "desired_node_version", "desired_image_family",
      #     "desired_node_pool_autoscaling", or "desired_workload_metadata_config"
      #     is specified and there is more than one node pool on the cluster.
      # @!attribute [rw] desired_image_type
      #   @return [String]
      #     The desired image type for the node pool.
      #     NOTE: Set the "desired_node_pool" field as well.
      # @!attribute [rw] desired_node_pool_autoscaling
      #   @return [Google::Container::V1beta1::NodePoolAutoscaling]
      #     Autoscaler configuration for the node pool specified in
      #     desired_node_pool_id. If there is only one pool in the
      #     cluster and desired_node_pool_id is not provided then
      #     the change applies to that single node pool.
      # @!attribute [rw] desired_locations
      #   @return [Array<String>]
      #     The desired list of Google Compute Engine
      #     [zones](https://cloud.google.com/compute/docs/zones#available) in which the cluster's nodes
      #     should be located. Changing the locations a cluster is in will result
      #     in nodes being either created or removed from the cluster, depending on
      #     whether locations are being added or removed.
      #
      #     This list must always include the cluster's primary zone.
      # @!attribute [rw] desired_master_authorized_networks_config
      #   @return [Google::Container::V1beta1::MasterAuthorizedNetworksConfig]
      #     The desired configuration options for master authorized networks feature.
      # @!attribute [rw] desired_pod_security_policy_config
      #   @return [Google::Container::V1beta1::PodSecurityPolicyConfig]
      #     The desired configuration options for the PodSecurityPolicy feature.
      # @!attribute [rw] desired_cluster_autoscaling
      #   @return [Google::Container::V1beta1::ClusterAutoscaling]
      #     Cluster-level autoscaling configuration.
      # @!attribute [rw] desired_binary_authorization
      #   @return [Google::Container::V1beta1::BinaryAuthorization]
      #     The desired configuration options for the Binary Authorization feature.
      # @!attribute [rw] desired_logging_service
      #   @return [String]
      #     The logging service the cluster should use to write metrics.
      #     Currently available options:
      #
      #     * "logging.googleapis.com/kubernetes" - the Google Cloud Logging
      #       service with Kubernetes-native resource model
      #     * "logging.googleapis.com" - the Google Cloud Logging service
      #     * "none" - no logs will be exported from the cluster
      # @!attribute [rw] desired_resource_usage_export_config
      #   @return [Google::Container::V1beta1::ResourceUsageExportConfig]
      #     The desired configuration for exporting resource usage.
      # @!attribute [rw] desired_vertical_pod_autoscaling
      #   @return [Google::Container::V1beta1::VerticalPodAutoscaling]
      #     Cluster-level Vertical Pod Autoscaling configuration.
      # @!attribute [rw] desired_intra_node_visibility_config
      #   @return [Google::Container::V1beta1::IntraNodeVisibilityConfig]
      #     The desired config of Intra-node visibility.
      # @!attribute [rw] desired_master_version
      #   @return [String]
      #     The Kubernetes version to change the master to. The only valid value is the
      #     latest supported version.
      #
      #     Users may specify either explicit versions offered by
      #     Kubernetes Engine or version aliases, which have the following behavior:
      #
      #     * "latest": picks the highest valid Kubernetes version
      #     * "1.X": picks the highest valid patch+gke.N patch in the 1.X version
      #     * "1.X.Y": picks the highest valid gke.N patch in the 1.X.Y version
      #     * "1.X.Y-gke.N": picks an explicit Kubernetes version
      #     * "-": picks the default Kubernetes version
      class ClusterUpdate; end

      # This operation resource represents operations that may have happened or are
      # happening on the cluster. All fields are output only.
      # @!attribute [rw] name
      #   @return [String]
      #     The server-assigned ID for the operation.
      # @!attribute [rw] zone
      #   @return [String]
      #     The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the operation
      #     is taking place.
      #     This field is deprecated, use location instead.
      # @!attribute [rw] operation_type
      #   @return [Google::Container::V1beta1::Operation::Type]
      #     The operation type.
      # @!attribute [rw] status
      #   @return [Google::Container::V1beta1::Operation::Status]
      #     The current status of the operation.
      # @!attribute [rw] detail
      #   @return [String]
      #     Detailed operation progress, if available.
      # @!attribute [rw] status_message
      #   @return [String]
      #     If an error has occurred, a textual description of the error.
      # @!attribute [rw] self_link
      #   @return [String]
      #     Server-defined URL for the resource.
      # @!attribute [rw] target_link
      #   @return [String]
      #     Server-defined URL for the target of the operation.
      # @!attribute [rw] location
      #   @return [String]
      #     [Output only] The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) or
      #     [region](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) in which
      #     the cluster resides.
      # @!attribute [rw] start_time
      #   @return [String]
      #     [Output only] The time the operation started, in
      #     [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
      # @!attribute [rw] end_time
      #   @return [String]
      #     [Output only] The time the operation completed, in
      #     [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
      # @!attribute [rw] progress
      #   @return [Google::Container::V1beta1::OperationProgress]
      #     [Output only] Progress information for an operation.
      # @!attribute [rw] cluster_conditions
      #   @return [Array<Google::Container::V1beta1::StatusCondition>]
      #     Which conditions caused the current cluster state.
      # @!attribute [rw] nodepool_conditions
      #   @return [Array<Google::Container::V1beta1::StatusCondition>]
      #     Which conditions caused the current node pool state.
      class Operation
        # Current status of the operation.
        module Status
          # Not set.
          STATUS_UNSPECIFIED = 0

          # The operation has been created.
          PENDING = 1

          # The operation is currently running.
          RUNNING = 2

          # The operation is done, either cancelled or completed.
          DONE = 3

          # The operation is aborting.
          ABORTING = 4
        end

        # Operation type.
        module Type
          # Not set.
          TYPE_UNSPECIFIED = 0

          # Cluster create.
          CREATE_CLUSTER = 1

          # Cluster delete.
          DELETE_CLUSTER = 2

          # A master upgrade.
          UPGRADE_MASTER = 3

          # A node upgrade.
          UPGRADE_NODES = 4

          # Cluster repair.
          REPAIR_CLUSTER = 5

          # Cluster update.
          UPDATE_CLUSTER = 6

          # Node pool create.
          CREATE_NODE_POOL = 7

          # Node pool delete.
          DELETE_NODE_POOL = 8

          # Set node pool management.
          SET_NODE_POOL_MANAGEMENT = 9

          # Automatic node pool repair.
          AUTO_REPAIR_NODES = 10

          # Automatic node upgrade.
          AUTO_UPGRADE_NODES = 11

          # Set labels.
          SET_LABELS = 12

          # Set/generate master auth materials
          SET_MASTER_AUTH = 13

          # Set node pool size.
          SET_NODE_POOL_SIZE = 14

          # Updates network policy for a cluster.
          SET_NETWORK_POLICY = 15

          # Set the maintenance policy.
          SET_MAINTENANCE_POLICY = 16
        end
      end

      # Information about operation (or operation stage) progress.
      # @!attribute [rw] name
      #   @return [String]
      #     A non-parameterized string describing an operation stage.
      #     Unset for single-stage operations.
      # @!attribute [rw] status
      #   @return [Google::Container::V1beta1::Operation::Status]
      #     Status of an operation stage.
      #     Unset for single-stage operations.
      # @!attribute [rw] metrics
      #   @return [Array<Google::Container::V1beta1::OperationProgress::Metric>]
      #     Progress metric bundle, for example:
      #       metrics: [{name: "nodes done",     int_value: 15},
      #                 {name: "nodes total",    int_value: 32}]
      #     or
      #       metrics: [{name: "progress",       double_value: 0.56},
      #                 {name: "progress scale", double_value: 1.0}]
      # @!attribute [rw] stages
      #   @return [Array<Google::Container::V1beta1::OperationProgress>]
      #     Substages of an operation or a stage.
      class OperationProgress
        # Progress metric is (string, int|float|string) pair.
        # @!attribute [rw] name
        #   @return [String]
        #     Metric name, required.
        #     e.g., "nodes total", "percent done"
        # @!attribute [rw] int_value
        #   @return [Integer]
        #     For metrics with integer value.
        # @!attribute [rw] double_value
        #   @return [Float]
        #     For metrics with floating point value.
        # @!attribute [rw] string_value
        #   @return [String]
        #     For metrics with custom values (ratios, visual progress, etc.).
        class Metric; end
      end

      # CreateClusterRequest creates a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] cluster
      #   @return [Google::Container::V1beta1::Cluster]
      #     Required. A [cluster
      #     resource](https://cloud.google.com/container-engine/reference/rest/v1beta1/projects.zones.clusters)
      # @!attribute [rw] parent
      #   @return [String]
      #     The parent (project and location) where the cluster will be created.
      #     Specified in the format `projects/*/locations/*`.
      class CreateClusterRequest; end

      # GetClusterRequest gets the settings of a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to retrieve.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to retrieve.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class GetClusterRequest; end

      # UpdateClusterRequest updates the settings of a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] update
      #   @return [Google::Container::V1beta1::ClusterUpdate]
      #     Required. A description of the update.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to update.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class UpdateClusterRequest; end

      # SetNodePoolVersionRequest updates the version of a node pool.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_pool_id
      #   @return [String]
      #     Required. Deprecated. The name of the node pool to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_version
      #   @return [String]
      #     Required. The Kubernetes version to change the nodes to (typically an
      #     upgrade).
      #
      #     Users may specify either explicit versions offered by Kubernetes Engine or
      #     version aliases, which have the following behavior:
      #
      #     * "latest": picks the highest valid Kubernetes version
      #     * "1.X": picks the highest valid patch+gke.N patch in the 1.X version
      #     * "1.X.Y": picks the highest valid gke.N patch in the 1.X.Y version
      #     * "1.X.Y-gke.N": picks an explicit Kubernetes version
      #     * "-": picks the Kubernetes master version
      # @!attribute [rw] image_type
      #   @return [String]
      #     Required. The desired image type for the node pool.
      # @!attribute [rw] workload_metadata_config
      #   @return [Google::Container::V1beta1::WorkloadMetadataConfig]
      #     The desired image type for the node pool.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster, node pool) of the node pool to
      #     update. Specified in the format
      #     `projects/*/locations/*/clusters/*/nodePools/*`.
      class UpdateNodePoolRequest; end

      # SetNodePoolAutoscalingRequest sets the autoscaler settings of a node pool.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_pool_id
      #   @return [String]
      #     Required. Deprecated. The name of the node pool to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] autoscaling
      #   @return [Google::Container::V1beta1::NodePoolAutoscaling]
      #     Required. Autoscaling configuration for the node pool.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster, node pool) of the node pool to set
      #     autoscaler settings. Specified in the format
      #     `projects/*/locations/*/clusters/*/nodePools/*`.
      class SetNodePoolAutoscalingRequest; end

      # SetLoggingServiceRequest sets the logging service of a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] logging_service
      #   @return [String]
      #     Required. The logging service the cluster should use to write metrics.
      #     Currently available options:
      #
      #     * "logging.googleapis.com" - the Google Cloud Logging service
      #     * "none" - no metrics will be exported from the cluster
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to set logging.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class SetLoggingServiceRequest; end

      # SetMonitoringServiceRequest sets the monitoring service of a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] monitoring_service
      #   @return [String]
      #     Required. The monitoring service the cluster should use to write metrics.
      #     Currently available options:
      #
      #     * "monitoring.googleapis.com" - the Google Cloud Monitoring service
      #     * "none" - no metrics will be exported from the cluster
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to set monitoring.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class SetMonitoringServiceRequest; end

      # SetAddonsRequest sets the addons associated with the cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] addons_config
      #   @return [Google::Container::V1beta1::AddonsConfig]
      #     Required. The desired configurations for the various addons available to run in the
      #     cluster.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to set addons.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class SetAddonsConfigRequest; end

      # SetLocationsRequest sets the locations of the cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] locations
      #   @return [Array<String>]
      #     Required. The desired list of Google Compute Engine
      #     [zones](https://cloud.google.com/compute/docs/zones#available) in which the cluster's nodes
      #     should be located. Changing the locations a cluster is in will result
      #     in nodes being either created or removed from the cluster, depending on
      #     whether locations are being added or removed.
      #
      #     This list must always include the cluster's primary zone.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to set locations.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class SetLocationsRequest; end

      # UpdateMasterRequest updates the master of the cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] master_version
      #   @return [String]
      #     Required. The Kubernetes version to change the master to.
      #
      #     Users may specify either explicit versions offered by
      #     Kubernetes Engine or version aliases, which have the following behavior:
      #
      #     * "latest": picks the highest valid Kubernetes version
      #     * "1.X": picks the highest valid patch+gke.N patch in the 1.X version
      #     * "1.X.Y": picks the highest valid gke.N patch in the 1.X.Y version
      #     * "1.X.Y-gke.N": picks an explicit Kubernetes version
      #     * "-": picks the default Kubernetes version
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to update.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class UpdateMasterRequest; end

      # SetMasterAuthRequest updates the admin password of a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to upgrade.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] action
      #   @return [Google::Container::V1beta1::SetMasterAuthRequest::Action]
      #     Required. The exact form of action to be taken on the master auth.
      # @!attribute [rw] update
      #   @return [Google::Container::V1beta1::MasterAuth]
      #     Required. A description of the update.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to set auth.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class SetMasterAuthRequest
        # Operation type: what type update to perform.
        module Action
          # Operation is unknown and will error out.
          UNKNOWN = 0

          # Set the password to a user generated value.
          SET_PASSWORD = 1

          # Generate a new password and set it to that.
          GENERATE_PASSWORD = 2

          # Set the username.  If an empty username is provided, basic authentication
          # is disabled for the cluster.  If a non-empty username is provided, basic
          # authentication is enabled, with either a provided password or a generated
          # one.
          SET_USERNAME = 3
        end
      end

      # DeleteClusterRequest deletes a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to delete.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster) of the cluster to delete.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class DeleteClusterRequest; end

      # ListClustersRequest lists clusters.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides, or "-" for all zones.
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] parent
      #   @return [String]
      #     The parent (project and location) where the clusters will be listed.
      #     Specified in the format `projects/*/locations/*`.
      #     Location "-" matches all zones and all regions.
      class ListClustersRequest; end

      # ListClustersResponse is the result of ListClustersRequest.
      # @!attribute [rw] clusters
      #   @return [Array<Google::Container::V1beta1::Cluster>]
      #     A list of clusters in the project in the specified zone, or
      #     across all ones.
      # @!attribute [rw] missing_zones
      #   @return [Array<String>]
      #     If any zones are listed here, the list of clusters returned
      #     may be missing those zones.
      class ListClustersResponse; end

      # GetOperationRequest gets a single operation.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] operation_id
      #   @return [String]
      #     Required. Deprecated. The server-assigned `name` of the operation.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, operation id) of the operation to get.
      #     Specified in the format `projects/*/locations/*/operations/*`.
      class GetOperationRequest; end

      # ListOperationsRequest lists operations.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) to return operations for, or `-` for
      #     all zones. This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] parent
      #   @return [String]
      #     The parent (project and location) where the operations will be listed.
      #     Specified in the format `projects/*/locations/*`.
      #     Location "-" matches all zones and all regions.
      class ListOperationsRequest; end

      # CancelOperationRequest cancels a single operation.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the operation resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] operation_id
      #   @return [String]
      #     Required. Deprecated. The server-assigned `name` of the operation.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, operation id) of the operation to cancel.
      #     Specified in the format `projects/*/locations/*/operations/*`.
      class CancelOperationRequest; end

      # ListOperationsResponse is the result of ListOperationsRequest.
      # @!attribute [rw] operations
      #   @return [Array<Google::Container::V1beta1::Operation>]
      #     A list of operations in the project in the specified zone.
      # @!attribute [rw] missing_zones
      #   @return [Array<String>]
      #     If any zones are listed here, the list of operations returned
      #     may be missing the operations from those zones.
      class ListOperationsResponse; end

      # Gets the current Kubernetes Engine service configuration.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) to return operations for.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project and location) of the server config to get,
      #     specified in the format `projects/*/locations/*`.
      class GetServerConfigRequest; end

      # Kubernetes Engine service configuration.
      # @!attribute [rw] default_cluster_version
      #   @return [String]
      #     Version of Kubernetes the service deploys by default.
      # @!attribute [rw] valid_node_versions
      #   @return [Array<String>]
      #     List of valid node upgrade target versions.
      # @!attribute [rw] default_image_type
      #   @return [String]
      #     Default image type.
      # @!attribute [rw] valid_image_types
      #   @return [Array<String>]
      #     List of valid image types.
      # @!attribute [rw] valid_master_versions
      #   @return [Array<String>]
      #     List of valid master versions.
      class ServerConfig; end

      # CreateNodePoolRequest creates a node pool for a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://developers.google.com/console/help/new/#projectnumber).
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster.
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] node_pool
      #   @return [Google::Container::V1beta1::NodePool]
      #     Required. The node pool to create.
      # @!attribute [rw] parent
      #   @return [String]
      #     The parent (project, location, cluster id) where the node pool will be
      #     created. Specified in the format
      #     `projects/*/locations/*/clusters/*`.
      class CreateNodePoolRequest; end

      # DeleteNodePoolRequest deletes a node pool for a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://developers.google.com/console/help/new/#projectnumber).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_pool_id
      #   @return [String]
      #     Required. Deprecated. The name of the node pool to delete.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster, node pool id) of the node pool to
      #     delete. Specified in the format
      #     `projects/*/locations/*/clusters/*/nodePools/*`.
      class DeleteNodePoolRequest; end

      # ListNodePoolsRequest lists the node pool(s) for a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://developers.google.com/console/help/new/#projectnumber).
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster.
      #     This field has been deprecated and replaced by the parent field.
      # @!attribute [rw] parent
      #   @return [String]
      #     The parent (project, location, cluster id) where the node pools will be
      #     listed. Specified in the format `projects/*/locations/*/clusters/*`.
      class ListNodePoolsRequest; end

      # GetNodePoolRequest retrieves a node pool for a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://developers.google.com/console/help/new/#projectnumber).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_pool_id
      #   @return [String]
      #     Required. Deprecated. The name of the node pool.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster, node pool id) of the node pool to
      #     get. Specified in the format
      #     `projects/*/locations/*/clusters/*/nodePools/*`.
      class GetNodePoolRequest; end

      # NodePool contains the name and configuration for a cluster's node pool.
      # Node pools are a set of nodes (i.e. VM's), with a common configuration and
      # specification, under the control of the cluster master. They may have a set
      # of Kubernetes labels applied to them, which may be used to reference them
      # during pod scheduling. They may also be resized up or down, to accommodate
      # the workload.
      # @!attribute [rw] name
      #   @return [String]
      #     The name of the node pool.
      # @!attribute [rw] config
      #   @return [Google::Container::V1beta1::NodeConfig]
      #     The node configuration of the pool.
      # @!attribute [rw] initial_node_count
      #   @return [Integer]
      #     The initial node count for the pool. You must ensure that your
      #     Compute Engine <a href="/compute/docs/resource-quotas">resource quota</a>
      #     is sufficient for this number of instances. You must also have available
      #     firewall and routes quota.
      # @!attribute [rw] self_link
      #   @return [String]
      #     [Output only] Server-defined URL for the resource.
      # @!attribute [rw] version
      #   @return [String]
      #     The version of the Kubernetes of this node.
      # @!attribute [rw] instance_group_urls
      #   @return [Array<String>]
      #     [Output only] The resource URLs of the [managed instance
      #     groups](https://cloud.google.com/compute/docs/instance-groups/creating-groups-of-managed-instances)
      #     associated with this node pool.
      # @!attribute [rw] status
      #   @return [Google::Container::V1beta1::NodePool::Status]
      #     [Output only] The status of the nodes in this pool instance.
      # @!attribute [rw] status_message
      #   @return [String]
      #     [Output only] Additional information about the current status of this
      #     node pool instance, if available.
      # @!attribute [rw] autoscaling
      #   @return [Google::Container::V1beta1::NodePoolAutoscaling]
      #     Autoscaler configuration for this NodePool. Autoscaler is enabled
      #     only if a valid configuration is present.
      # @!attribute [rw] management
      #   @return [Google::Container::V1beta1::NodeManagement]
      #     NodeManagement configuration for this NodePool.
      # @!attribute [rw] max_pods_constraint
      #   @return [Google::Container::V1beta1::MaxPodsConstraint]
      #     The constraint on the maximum number of pods that can be run
      #     simultaneously on a node in the node pool.
      # @!attribute [rw] conditions
      #   @return [Array<Google::Container::V1beta1::StatusCondition>]
      #     Which conditions caused the current node pool state.
      # @!attribute [rw] pod_ipv4_cidr_size
      #   @return [Integer]
      #     [Output only] The pod CIDR block size per node in this node pool.
      class NodePool
        # The current status of the node pool instance.
        module Status
          # Not set.
          STATUS_UNSPECIFIED = 0

          # The PROVISIONING state indicates the node pool is being created.
          PROVISIONING = 1

          # The RUNNING state indicates the node pool has been created
          # and is fully usable.
          RUNNING = 2

          # The RUNNING_WITH_ERROR state indicates the node pool has been created
          # and is partially usable. Some error state has occurred and some
          # functionality may be impaired. Customer may need to reissue a request
          # or trigger a new update.
          RUNNING_WITH_ERROR = 3

          # The RECONCILING state indicates that some work is actively being done on
          # the node pool, such as upgrading node software. Details can
          # be found in the `statusMessage` field.
          RECONCILING = 4

          # The STOPPING state indicates the node pool is being deleted.
          STOPPING = 5

          # The ERROR state indicates the node pool may be unusable. Details
          # can be found in the `statusMessage` field.
          ERROR = 6
        end
      end

      # NodeManagement defines the set of node management services turned on for the
      # node pool.
      # @!attribute [rw] auto_upgrade
      #   @return [true, false]
      #     Whether the nodes will be automatically upgraded.
      # @!attribute [rw] auto_repair
      #   @return [true, false]
      #     Whether the nodes will be automatically repaired.
      # @!attribute [rw] upgrade_options
      #   @return [Google::Container::V1beta1::AutoUpgradeOptions]
      #     Specifies the Auto Upgrade knobs for the node pool.
      class NodeManagement; end

      # AutoUpgradeOptions defines the set of options for the user to control how
      # the Auto Upgrades will proceed.
      # @!attribute [rw] auto_upgrade_start_time
      #   @return [String]
      #     [Output only] This field is set when upgrades are about to commence
      #     with the approximate start time for the upgrades, in
      #     [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
      # @!attribute [rw] description
      #   @return [String]
      #     [Output only] This field is set when upgrades are about to commence
      #     with the description of the upgrade.
      class AutoUpgradeOptions; end

      # MaintenancePolicy defines the maintenance policy to be used for the cluster.
      # @!attribute [rw] window
      #   @return [Google::Container::V1beta1::MaintenanceWindow]
      #     Specifies the maintenance window in which maintenance may be performed.
      # @!attribute [rw] resource_version
      #   @return [String]
      #     A hash identifying the version of this policy, so that updates to fields of
      #     the policy won't accidentally undo intermediate changes (and so that users
      #     of the API unaware of some fields won't accidentally remove other fields).
      #     Make a <code>get()</code> request to the cluster to get the current
      #     resource version and include it with requests to set the policy.
      class MaintenancePolicy; end

      # MaintenanceWindow defines the maintenance window to be used for the cluster.
      # @!attribute [rw] daily_maintenance_window
      #   @return [Google::Container::V1beta1::DailyMaintenanceWindow]
      #     DailyMaintenanceWindow specifies a daily maintenance operation window.
      # @!attribute [rw] recurring_window
      #   @return [Google::Container::V1beta1::RecurringTimeWindow]
      #     RecurringWindow specifies some number of recurring time periods for
      #     maintenance to occur. The time windows may be overlapping. If no
      #     maintenance windows are set, maintenance can occur at any time.
      # @!attribute [rw] maintenance_exclusions
      #   @return [Hash{String => Google::Container::V1beta1::TimeWindow}]
      #     Exceptions to maintenance window. Non-emergency maintenance should not
      #     occur in these windows.
      class MaintenanceWindow; end

      # Represents an arbitrary window of time.
      # @!attribute [rw] start_time
      #   @return [Google::Protobuf::Timestamp]
      #     The time that the window first starts.
      # @!attribute [rw] end_time
      #   @return [Google::Protobuf::Timestamp]
      #     The time that the window ends. The end time should take place after the
      #     start time.
      class TimeWindow; end

      # Represents an arbitrary window of time that recurs.
      # @!attribute [rw] window
      #   @return [Google::Container::V1beta1::TimeWindow]
      #     The window of the first recurrence.
      # @!attribute [rw] recurrence
      #   @return [String]
      #     An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how
      #     this window reccurs. They go on for the span of time between the start and
      #     end time.
      #
      #     For example, to have something repeat every weekday, you'd use:
      #       <code>FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR</code>
      #     To repeat some window daily (equivalent to the DailyMaintenanceWindow):
      #       <code>FREQ=DAILY</code>
      #     For the first weekend of every month:
      #       <code>FREQ=MONTHLY;BYSETPOS=1;BYDAY=SA,SU</code>
      #     This specifies how frequently the window starts. Eg, if you wanted to have
      #     a 9-5 UTC-4 window every weekday, you'd use something like:
      #     <code>
      #       start time = 2019-01-01T09:00:00-0400
      #       end time = 2019-01-01T17:00:00-0400
      #       recurrence = FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR
      #     </code>
      #     Windows can span multiple days. Eg, to make the window encompass every
      #     weekend from midnight Saturday till the last minute of Sunday UTC:
      #     <code>
      #       start time = 2019-01-05T00:00:00Z
      #       end time = 2019-01-07T23:59:00Z
      #       recurrence = FREQ=WEEKLY;BYDAY=SA
      #     </code>
      #     Note the start and end time's specific dates are largely arbitrary except
      #     to specify duration of the window and when it first starts.
      #     The FREQ values of HOURLY, MINUTELY, and SECONDLY are not supported.
      class RecurringTimeWindow; end

      # Time window specified for daily maintenance operations.
      # @!attribute [rw] start_time
      #   @return [String]
      #     Time within the maintenance window to start the maintenance operations.
      #     It must be in format "HH:MM", where HH : [00-23] and MM : [00-59] GMT.
      # @!attribute [rw] duration
      #   @return [String]
      #     [Output only] Duration of the time window, automatically chosen to be
      #     smallest possible in the given scenario.
      class DailyMaintenanceWindow; end

      # SetNodePoolManagementRequest sets the node management properties of a node
      # pool.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to update.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_pool_id
      #   @return [String]
      #     Required. Deprecated. The name of the node pool to update.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] management
      #   @return [Google::Container::V1beta1::NodeManagement]
      #     Required. NodeManagement configuration for the node pool.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster, node pool id) of the node pool to set
      #     management properties. Specified in the format
      #     `projects/*/locations/*/clusters/*/nodePools/*`.
      class SetNodePoolManagementRequest; end

      # SetNodePoolSizeRequest sets the size a node
      # pool.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to update.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_pool_id
      #   @return [String]
      #     Required. Deprecated. The name of the node pool to update.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_count
      #   @return [Integer]
      #     Required. The desired node count for the pool.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster, node pool id) of the node pool to set
      #     size.
      #     Specified in the format `projects/*/locations/*/clusters/*/nodePools/*`.
      class SetNodePoolSizeRequest; end

      # RollbackNodePoolUpgradeRequest rollbacks the previously Aborted or Failed
      # NodePool upgrade. This will be an no-op if the last upgrade successfully
      # completed.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to rollback.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] node_pool_id
      #   @return [String]
      #     Required. Deprecated. The name of the node pool to rollback.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster, node pool id) of the node poll to
      #     rollback upgrade.
      #     Specified in the format `projects/*/locations/*/clusters/*/nodePools/*`.
      class RollbackNodePoolUpgradeRequest; end

      # ListNodePoolsResponse is the result of ListNodePoolsRequest.
      # @!attribute [rw] node_pools
      #   @return [Array<Google::Container::V1beta1::NodePool>]
      #     A list of node pools for a cluster.
      class ListNodePoolsResponse; end

      # ClusterAutoscaling contains global, per-cluster information
      # required by Cluster Autoscaler to automatically adjust
      # the size of the cluster and create/delete
      # node pools based on the current needs.
      # @!attribute [rw] enable_node_autoprovisioning
      #   @return [true, false]
      #     Enables automatic node pool creation and deletion.
      # @!attribute [rw] resource_limits
      #   @return [Array<Google::Container::V1beta1::ResourceLimit>]
      #     Contains global constraints regarding minimum and maximum
      #     amount of resources in the cluster.
      # @!attribute [rw] autoprovisioning_node_pool_defaults
      #   @return [Google::Container::V1beta1::AutoprovisioningNodePoolDefaults]
      #     AutoprovisioningNodePoolDefaults contains defaults for a node pool
      #     created by NAP.
      # @!attribute [rw] autoprovisioning_locations
      #   @return [Array<String>]
      #     The list of Google Compute Engine [zones](https://cloud.google.com/compute/docs/zones#available)
      #     in which the NodePool's nodes can be created by NAP.
      class ClusterAutoscaling; end

      # AutoprovisioningNodePoolDefaults contains defaults for a node pool created
      # by NAP.
      # @!attribute [rw] oauth_scopes
      #   @return [Array<String>]
      #     Scopes that are used by NAP when creating node pools. If oauth_scopes are
      #     specified, service_account should be empty.
      # @!attribute [rw] service_account
      #   @return [String]
      #     The Google Cloud Platform Service Account to be used by the node VMs. If
      #     service_account is specified, scopes should be empty.
      class AutoprovisioningNodePoolDefaults; end

      # Contains information about amount of some resource in the cluster.
      # For memory, value should be in GB.
      # @!attribute [rw] resource_type
      #   @return [String]
      #     Resource name "cpu", "memory" or gpu-specific string.
      # @!attribute [rw] minimum
      #   @return [Integer]
      #     Minimum amount of the resource in the cluster.
      # @!attribute [rw] maximum
      #   @return [Integer]
      #     Maximum amount of the resource in the cluster.
      class ResourceLimit; end

      # NodePoolAutoscaling contains information required by cluster autoscaler to
      # adjust the size of the node pool to the current cluster usage.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Is autoscaling enabled for this node pool.
      # @!attribute [rw] min_node_count
      #   @return [Integer]
      #     Minimum number of nodes in the NodePool. Must be >= 1 and <=
      #     max_node_count.
      # @!attribute [rw] max_node_count
      #   @return [Integer]
      #     Maximum number of nodes in the NodePool. Must be >= min_node_count. There
      #     has to enough quota to scale up the cluster.
      # @!attribute [rw] autoprovisioned
      #   @return [true, false]
      #     Can this node pool be deleted automatically.
      class NodePoolAutoscaling; end

      # SetLabelsRequest sets the Google Cloud Platform labels on a Google Container
      # Engine cluster, which will in turn set them for Google Compute Engine
      # resources used by that cluster
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://developers.google.com/console/help/new/#projectnumber).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] resource_labels
      #   @return [Hash{String => String}]
      #     Required. The labels to set for that cluster.
      # @!attribute [rw] label_fingerprint
      #   @return [String]
      #     Required. The fingerprint of the previous set of labels for this resource,
      #     used to detect conflicts. The fingerprint is initially generated by
      #     Kubernetes Engine and changes after every request to modify or update
      #     labels. You must always provide an up-to-date fingerprint hash when
      #     updating or changing labels. Make a <code>get()</code> request to the
      #     resource to get the latest fingerprint.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster id) of the cluster to set labels.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class SetLabelsRequest; end

      # SetLegacyAbacRequest enables or disables the ABAC authorization mechanism for
      # a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster to update.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Required. Whether ABAC authorization will be enabled in the cluster.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster id) of the cluster to set legacy abac.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class SetLegacyAbacRequest; end

      # StartIPRotationRequest creates a new IP for the cluster and then performs
      # a node upgrade on each node pool to point to the new IP.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://developers.google.com/console/help/new/#projectnumber).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster id) of the cluster to start IP
      #     rotation. Specified in the format `projects/*/locations/*/clusters/*`.
      # @!attribute [rw] rotate_credentials
      #   @return [true, false]
      #     Whether to rotate credentials during IP rotation.
      class StartIPRotationRequest; end

      # CompleteIPRotationRequest moves the cluster master back into single-IP mode.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://developers.google.com/console/help/new/#projectnumber).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster id) of the cluster to complete IP
      #     rotation. Specified in the format `projects/*/locations/*/clusters/*`.
      class CompleteIPRotationRequest; end

      # AcceleratorConfig represents a Hardware Accelerator request.
      # @!attribute [rw] accelerator_count
      #   @return [Integer]
      #     The number of the accelerator cards exposed to an instance.
      # @!attribute [rw] accelerator_type
      #   @return [String]
      #     The accelerator type resource name. List of supported accelerators
      #     [here](https://cloud.google.com/compute/docs/gpus)
      class AcceleratorConfig; end

      # WorkloadMetadataConfig defines the metadata configuration to expose to
      # workloads on the node pool.
      # @!attribute [rw] node_metadata
      #   @return [Google::Container::V1beta1::WorkloadMetadataConfig::NodeMetadata]
      #     NodeMetadata is the configuration for how to expose metadata to the
      #     workloads running on the node.
      class WorkloadMetadataConfig
        # NodeMetadata is the configuration for if and how to expose the node
        # metadata to the workload running on the node.
        module NodeMetadata
          # Not set.
          UNSPECIFIED = 0

          # Prevent workloads not in hostNetwork from accessing certain VM metadata,
          # specifically kube-env, which contains Kubelet credentials, and the
          # instance identity token.
          #
          # Metadata concealment is a temporary security solution available while the
          # bootstrapping process for cluster nodes is being redesigned with
          # significant security improvements.  This feature is scheduled to be
          # deprecated in the future and later removed.
          SECURE = 1

          # Expose all VM metadata to pods.
          EXPOSE = 2
        end
      end

      # SetNetworkPolicyRequest enables/disables network policy for a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. Deprecated. The Google Developers Console [project ID or project
      #     number](https://developers.google.com/console/help/new/#projectnumber).
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. Deprecated. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. Deprecated. The name of the cluster.
      #     This field has been deprecated and replaced by the name field.
      # @!attribute [rw] network_policy
      #   @return [Google::Container::V1beta1::NetworkPolicy]
      #     Required. Configuration options for the NetworkPolicy feature.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster id) of the cluster to set networking
      #     policy. Specified in the format `projects/*/locations/*/clusters/*`.
      class SetNetworkPolicyRequest; end

      # SetMaintenancePolicyRequest sets the maintenance policy for a cluster.
      # @!attribute [rw] project_id
      #   @return [String]
      #     Required. The Google Developers Console [project ID or project
      #     number](https://support.google.com/cloud/answer/6158840).
      # @!attribute [rw] zone
      #   @return [String]
      #     Required. The name of the Google Compute Engine
      #     [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster
      #     resides.
      # @!attribute [rw] cluster_id
      #   @return [String]
      #     Required. The name of the cluster to update.
      # @!attribute [rw] maintenance_policy
      #   @return [Google::Container::V1beta1::MaintenancePolicy]
      #     Required. The maintenance policy to be set for the cluster. An empty field
      #     clears the existing maintenance policy.
      # @!attribute [rw] name
      #   @return [String]
      #     The name (project, location, cluster id) of the cluster to set maintenance
      #     policy.
      #     Specified in the format `projects/*/locations/*/clusters/*`.
      class SetMaintenancePolicyRequest; end

      # ListLocationsRequest is used to request the locations that offer GKE.
      # @!attribute [rw] parent
      #   @return [String]
      #     Required. Contains the name of the resource requested.
      #     Specified in the format `projects/*`.
      class ListLocationsRequest; end

      # ListLocationsResponse returns the list of all GKE locations and their
      # recommendation state.
      # @!attribute [rw] locations
      #   @return [Array<Google::Container::V1beta1::Location>]
      #     A full list of GKE locations.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     Only return ListLocationsResponse that occur after the page_token. This
      #     value should be populated from the ListLocationsResponse.next_page_token if
      #     that response token was set (which happens when listing more Locations than
      #     fit in a single ListLocationsResponse).
      class ListLocationsResponse; end

      # Location returns the location name, and if the location is recommended
      # for GKE cluster scheduling.
      # @!attribute [rw] type
      #   @return [Google::Container::V1beta1::Location::LocationType]
      #     Contains the type of location this Location is for.
      #     Regional or Zonal.
      # @!attribute [rw] name
      #   @return [String]
      #     Contains the name of the resource requested.
      #     Specified in the format `projects/*/locations/*`.
      # @!attribute [rw] recommended
      #   @return [true, false]
      #     Whether the location is recomended for GKE cluster scheduling.
      class Location
        # LocationType is the type of GKE location, regional or zonal.
        module LocationType
          # LOCATION_TYPE_UNSPECIFIED means the location type was not determined.
          LOCATION_TYPE_UNSPECIFIED = 0

          # A GKE Location where Zonal clusters can be created.
          ZONE = 1

          # A GKE Location where Regional clusters can be created.
          REGION = 2
        end
      end

      # StatusCondition describes why a cluster or a node pool has a certain status
      # (e.g., ERROR or DEGRADED).
      # @!attribute [rw] code
      #   @return [Google::Container::V1beta1::StatusCondition::Code]
      #     Machine-friendly representation of the condition
      # @!attribute [rw] message
      #   @return [String]
      #     Human-friendly representation of the condition
      class StatusCondition
        # Code for each condition
        module Code
          # UNKNOWN indicates a generic condition.
          UNKNOWN = 0

          # GCE_STOCKOUT indicates a Google Compute Engine stockout.
          GCE_STOCKOUT = 1

          # GKE_SERVICE_ACCOUNT_DELETED indicates that the user deleted their robot
          # service account.
          GKE_SERVICE_ACCOUNT_DELETED = 2

          # Google Compute Engine quota was exceeded.
          GCE_QUOTA_EXCEEDED = 3

          # Cluster state was manually changed by an SRE due to a system logic error.
          SET_BY_OPERATOR = 4

          # Unable to perform an encrypt operation against the CloudKMS key used for
          # etcd level encryption.
          # More codes TBA
          CLOUD_KMS_KEY_ERROR = 7
        end
      end

      # NetworkConfig reports the relative names of network & subnetwork.
      # @!attribute [rw] network
      #   @return [String]
      #     Output only. The relative name of the Google Compute Engine
      #     {Google::Container::V1beta1::NetworkConfig#network network}(https://cloud.google.com/compute/docs/networks-and-firewalls#networks) to which
      #     the cluster is connected.
      #     Example: projects/my-project/global/networks/my-network
      # @!attribute [rw] subnetwork
      #   @return [String]
      #     Output only. The relative name of the Google Compute Engine
      #     [subnetwork](https://cloud.google.com/compute/docs/vpc) to which the cluster is connected.
      #     Example: projects/my-project/regions/us-central1/subnetworks/my-subnet
      # @!attribute [rw] enable_intra_node_visibility
      #   @return [true, false]
      #     Whether Intra-node visibility is enabled for this cluster.
      #     This makes same node pod to pod traffic visible for VPC network.
      class NetworkConfig; end

      # ListUsableSubnetworksRequest requests the list of usable subnetworks.
      # available to a user for creating clusters.
      # @!attribute [rw] parent
      #   @return [String]
      #     Required. The parent project where subnetworks are usable.
      #     Specified in the format `projects/*`.
      # @!attribute [rw] filter
      #   @return [String]
      #     Filtering currently only supports equality on the networkProjectId and must
      #     be in the form: "networkProjectId=[PROJECTID]", where `networkProjectId`
      #     is the project which owns the listed subnetworks. This defaults to the
      #     parent project ID.
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     The max number of results per page that should be returned. If the number
      #     of available results is larger than `page_size`, a `next_page_token` is
      #     returned which can be used to get the next page of results in subsequent
      #     requests. Acceptable values are 0 to 500, inclusive. (Default: 500)
      # @!attribute [rw] page_token
      #   @return [String]
      #     Specifies a page token to use. Set this to the nextPageToken returned by
      #     previous list requests to get the next page of results.
      class ListUsableSubnetworksRequest; end

      # ListUsableSubnetworksResponse is the response of
      # ListUsableSubnetworksRequest.
      # @!attribute [rw] subnetworks
      #   @return [Array<Google::Container::V1beta1::UsableSubnetwork>]
      #     A list of usable subnetworks in the specified network project.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     This token allows you to get the next page of results for list requests.
      #     If the number of results is larger than `page_size`, use the
      #     `next_page_token` as a value for the query parameter `page_token` in the
      #     next request. The value will become empty when there are no more pages.
      class ListUsableSubnetworksResponse; end

      # Secondary IP range of a usable subnetwork.
      # @!attribute [rw] range_name
      #   @return [String]
      #     The name associated with this subnetwork secondary range, used when adding
      #     an alias IP range to a VM instance.
      # @!attribute [rw] ip_cidr_range
      #   @return [String]
      #     The range of IP addresses belonging to this subnetwork secondary range.
      # @!attribute [rw] status
      #   @return [Google::Container::V1beta1::UsableSubnetworkSecondaryRange::Status]
      #     This field is to determine the status of the secondary range programmably.
      class UsableSubnetworkSecondaryRange
        # Status shows the current usage of a secondary IP range.
        module Status
          # UNKNOWN is the zero value of the Status enum. It's not a valid status.
          UNKNOWN = 0

          # UNUSED denotes that this range is unclaimed by any cluster.
          UNUSED = 1

          # IN_USE_SERVICE denotes that this range is claimed by a cluster for
          # services. It cannot be used for other clusters.
          IN_USE_SERVICE = 2

          # IN_USE_SHAREABLE_POD denotes this range was created by the network admin
          # and is currently claimed by a cluster for pods. It can only be used by
          # other clusters as a pod range.
          IN_USE_SHAREABLE_POD = 3

          # IN_USE_MANAGED_POD denotes this range was created by GKE and is claimed
          # for pods. It cannot be used for other clusters.
          IN_USE_MANAGED_POD = 4
        end
      end

      # UsableSubnetwork resource returns the subnetwork name, its associated network
      # and the primary CIDR range.
      # @!attribute [rw] subnetwork
      #   @return [String]
      #     Subnetwork Name.
      #     Example: projects/my-project/regions/us-central1/subnetworks/my-subnet
      # @!attribute [rw] network
      #   @return [String]
      #     Network Name.
      #     Example: projects/my-project/global/networks/my-network
      # @!attribute [rw] ip_cidr_range
      #   @return [String]
      #     The range of internal addresses that are owned by this subnetwork.
      # @!attribute [rw] secondary_ip_ranges
      #   @return [Array<Google::Container::V1beta1::UsableSubnetworkSecondaryRange>]
      #     Secondary IP ranges.
      # @!attribute [rw] status_message
      #   @return [String]
      #     A human readable status message representing the reasons for cases where
      #     the caller cannot use the secondary ranges under the subnet. For example if
      #     the secondary_ip_ranges is empty due to a permission issue, an insufficient
      #     permission message will be given by status_message.
      class UsableSubnetwork; end

      # VerticalPodAutoscaling contains global, per-cluster information
      # required by Vertical Pod Autoscaler to automatically adjust
      # the resources of pods controlled by it.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Enables vertical pod autoscaling.
      class VerticalPodAutoscaling; end

      # IntraNodeVisibilityConfig contains the desired config of the intra-node
      # visibility on this cluster.
      # @!attribute [rw] enabled
      #   @return [true, false]
      #     Enables intra node visibility for this cluster.
      class IntraNodeVisibilityConfig; end

      # Constraints applied to pods.
      # @!attribute [rw] max_pods_per_node
      #   @return [Integer]
      #     Constraint enforced on the max num of pods per node.
      class MaxPodsConstraint; end

      # Configuration of etcd encryption.
      # @!attribute [rw] state
      #   @return [Google::Container::V1beta1::DatabaseEncryption::State]
      #     Denotes the state of etcd encryption.
      # @!attribute [rw] key_name
      #   @return [String]
      #     Name of CloudKMS key to use for the encryption of secrets in etcd.
      #     Ex. projects/my-project/locations/global/keyRings/my-ring/cryptoKeys/my-key
      class DatabaseEncryption
        # State of etcd encryption.
        module State
          # Should never be set
          UNKNOWN = 0

          # Secrets in etcd are encrypted.
          ENCRYPTED = 1

          # Secrets in etcd are stored in plain text (at etcd level) - this is
          # unrelated to Google Compute Engine level full disk encryption.
          DECRYPTED = 2
        end
      end

      # Configuration for exporting cluster resource usages.
      # @!attribute [rw] bigquery_destination
      #   @return [Google::Container::V1beta1::ResourceUsageExportConfig::BigQueryDestination]
      #     Configuration to use BigQuery as usage export destination.
      # @!attribute [rw] enable_network_egress_metering
      #   @return [true, false]
      #     Whether to enable network egress metering for this cluster. If enabled, a
      #     daemonset will be created in the cluster to meter network egress traffic.
      # @!attribute [rw] consumption_metering_config
      #   @return [Google::Container::V1beta1::ResourceUsageExportConfig::ConsumptionMeteringConfig]
      #     Configuration to enable resource consumption metering.
      class ResourceUsageExportConfig
        # Parameters for using BigQuery as the destination of resource usage export.
        # @!attribute [rw] dataset_id
        #   @return [String]
        #     The ID of a BigQuery Dataset.
        class BigQueryDestination; end

        # Parameters for controlling consumption metering.
        # @!attribute [rw] enabled
        #   @return [true, false]
        #     Whether to enable consumption metering for this cluster. If enabled, a
        #     second BigQuery table will be created to hold resource consumption
        #     records.
        class ConsumptionMeteringConfig; end
      end
    end
  end
end