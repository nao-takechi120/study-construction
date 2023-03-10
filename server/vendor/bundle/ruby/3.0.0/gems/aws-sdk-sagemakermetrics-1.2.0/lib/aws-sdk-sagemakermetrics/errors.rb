# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws::SageMakerMetrics

  # When SageMakerMetrics returns an error response, the Ruby SDK constructs and raises an error.
  # These errors all extend Aws::SageMakerMetrics::Errors::ServiceError < {Aws::Errors::ServiceError}
  #
  # You can rescue all SageMakerMetrics errors using ServiceError:
  #
  #     begin
  #       # do stuff
  #     rescue Aws::SageMakerMetrics::Errors::ServiceError
  #       # rescues all SageMakerMetrics API errors
  #     end
  #
  #
  # ## Request Context
  # ServiceError objects have a {Aws::Errors::ServiceError#context #context} method that returns
  # information about the request that generated the error.
  # See {Seahorse::Client::RequestContext} for more information.
  #
  # ## Error Classes
  #
  # Additionally, error classes are dynamically generated for service errors based on the error code
  # if they are not defined above.
  module Errors

    extend Aws::Errors::DynamicErrors

  end
end
