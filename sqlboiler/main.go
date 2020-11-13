package main

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/ryutah/learn-orm/sqlboiler/model"

	"context"

	_ "github.com/go-sql-driver/mysql"
	"github.com/volatiletech/sqlboiler/queries/qm"
)

func main() {
	db, err := sql.Open(
		"mysql",
		"user:pass@tcp(host.docker.internal)/sample?parseTime=true&charset=utf8mb4,utf8&collation=utf8mb4_unicode_ci",
	)
	if err != nil {
		log.Fatalf("failed to open db: %v", err)
	}
	defer db.Close()

	ctx := context.Background()
	user, err := model.Users(qm.Load(model.UserRels.Emails), model.UserWhere.ID.EQ(1)).One(ctx, db)
	if err != nil {
		log.Fatalf("failed to get user: %v", err)
	}

	fmt.Println("---------------------------------")
	fmt.Printf("%#v\n", user)
	for _, e := range user.R.Emails {
		fmt.Printf("%#v\n", e)
	}
	fmt.Println("---------------------------------")

	users, err := model.Users(
		qm.Load(model.UserRels.Emails),
		qm.InnerJoin(
			fmt.Sprintf(
				"%s on %s.%s = %s.%s", model.TableNames.Email,
				model.TableNames.Email, model.EmailColumns.UserID,
				model.TableNames.User, model.UserColumns.ID,
			),
		),
	).All(ctx, db)
	if err != nil {
		log.Fatalf("failed to get users: %v", err)
	}

	for _, u := range users {
		fmt.Println("---------------------------------")
		fmt.Printf("%#v\n", u)
		for _, e := range u.R.Emails {
			fmt.Printf("%#v\n", e)
		}
		fmt.Println("---------------------------------")
	}
}
