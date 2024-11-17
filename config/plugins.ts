export default ({ env }) => ({
  // https://docs.strapi.io/dev-docs/plugins/users-permissions
  // expressed in seconds or a string describing a time span. Eg: 60, "45m", "10h", "2 days", "7d", "2y"
  // default = 30d
  'users-permissions': {
    config: {
      jwt: {
        expiresIn: '7d',
      },
    },
  },
});
