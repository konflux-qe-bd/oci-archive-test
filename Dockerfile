FROM registry.access.redhat.com/ubi9/ubi:latest as builder

RUN --mount=type=cache,target=/workdir \
  dnf -y install skopeo && skopeo copy docker://busybox oci:/buildcontext/out.ociarchive

FROM oci-archive:./out.ociarchive
RUN --mount=type=bind,from=builder,src=.,target=/var/tmp rm -v /buildcontext/out.ociarchive

CMD ["exit", "0"]
