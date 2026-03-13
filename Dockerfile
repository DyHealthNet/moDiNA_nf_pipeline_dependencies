FROM mambaorg/micromamba:1.5.1-lunar

# use alpine such that ps is available
LABEL image.author.name="Lis Arend"
LABEL image.author.email="lis.arend@tum.de"

COPY --chown=$MAMBA_USER:$MAMBA_USER env.yml /tmp/env.yml

RUN micromamba install -y -n base -f /tmp/env.yml && \
    micromamba clean --all --yes


# Fix the zorp/filefetcher cache directory issue
RUN mkdir -p ${MAMBA_ROOT_PREFIX}/share/.assets && \
    chmod 777 ${MAMBA_ROOT_PREFIX}/share/.assets

ARG MAMBA_DOCKERFILE_ACTIVATE=1

ENV PATH="${PATH}:${MAMBA_ROOT_PREFIX}/bin"
