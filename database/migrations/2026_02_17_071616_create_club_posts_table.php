<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
public function up(): void

{

    Schema::create('club_posts', function (Blueprint $table) {

        $table->uuid('id')->primary();

        $table->foreignUuid('club_id')->constrained()->onDelete('cascade');

        $table->foreignUuid('user_id')->constrained()->onDelete('cascade');

        $table->text('content');

        $table->string('photo_url')->nullable();

        $table->timestamps();

    });

}



public function down(): void

{

    Schema::dropIfExists('club_posts');

}
};
